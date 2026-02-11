import os
from typing import List, Dict
from qdrant_client import QdrantClient
from qdrant_client.models import Distance, VectorParams, PointStruct, Filter, FieldCondition, MatchValue
import uuid
from datetime import datetime
import requests
from dotenv import load_dotenv
import PyPDF2
import io

load_dotenv()

class RAGSystem:
    def __init__(self, qdrant_client: QdrantClient):
        self.client = qdrant_client
        self.openrouter_key = os.getenv("OPENROUTER_API_KEY")
        self.embedding_model = "openai/text-embedding-3-small"
        self.collection_name = "documents"
        
        # Create documents collection if not exists
        try:
            self.client.get_collection(self.collection_name)
        except:
            self.client.create_collection(
                collection_name=self.collection_name,
                vectors_config=VectorParams(size=1536, distance=Distance.COSINE)
            )
    
    def get_embedding(self, text: str) -> List[float]:
        """Generate embeddings using OpenRouter"""
        url = "https://openrouter.ai/api/v1/embeddings"
        
        headers = {
            "Authorization": f"Bearer {self.openrouter_key}",
            "Content-Type": "application/json"
        }
        
        data = {
            "model": self.embedding_model,
            "input": text
        }
        
        try:
            response = requests.post(url, headers=headers, json=data)
            response.raise_for_status()
            return response.json()["data"][0]["embedding"]
        except Exception as e:
            print(f"Embedding error: {str(e)}")
            # Return placeholder if embedding fails
            return [0.1] * 1536
    
    def extract_text_from_pdf(self, pdf_file) -> str:
        """Extract text from PDF file"""
        try:
            pdf_reader = PyPDF2.PdfReader(pdf_file)
            text = ""
            for page in pdf_reader.pages:
                text += page.extract_text() + "\n"
            return text
        except Exception as e:
            raise Exception(f"Error extracting PDF text: {str(e)}")
    
    def chunk_text(self, text: str, chunk_size: int = 500, overlap: int = 50) -> List[str]:
        """Split text into overlapping chunks"""
        words = text.split()
        chunks = []
        
        for i in range(0, len(words), chunk_size - overlap):
            chunk = ' '.join(words[i:i + chunk_size])
            if chunk:
                chunks.append(chunk)
        
        return chunks
    
    def index_document(self, text: str, filename: str, metadata: Dict = None) -> int:
        """Index a document by chunking and storing in Qdrant"""
        chunks = self.chunk_text(text)
        points = []
        
        for idx, chunk in enumerate(chunks):
            embedding = self.get_embedding(chunk)
            
            payload = {
                "text": chunk,
                "filename": filename,
                "chunk_index": idx,
                "timestamp": datetime.now().isoformat(),
                "metadata": metadata or {}
            }
            
            point = PointStruct(
                id=str(uuid.uuid4()),
                vector=embedding,
                payload=payload
            )
            points.append(point)
        
        self.client.upsert(
            collection_name=self.collection_name,
            points=points
        )
        
        return len(chunks)
    
    def search_documents(self, query: str, limit: int = 5) -> List[Dict]:
        """Search for relevant document chunks using query_points"""
        query_embedding = self.get_embedding(query)
        
        # Use query_points instead of search
        search_result = self.client.query_points(
            collection_name=self.collection_name,
            query=query_embedding,
            limit=limit
        )
        
        results = []
        for hit in search_result.points:
            results.append({
                "text": hit.payload["text"],
                "filename": hit.payload["filename"],
                "score": hit.score,
                "chunk_index": hit.payload.get("chunk_index", 0)
            })
        
        return results
    
    def get_context_for_query(self, query: str, limit: int = 3) -> str:
        """Get relevant context for a query"""
        results = self.search_documents(query, limit)
        
        if not results:
            return ""
        
        context_parts = []
        for idx, result in enumerate(results):
            context_parts.append(
                f"[Document: {result['filename']} - Chunk {result['chunk_index']}]\n{result['text']}"
            )
        
        return "\n\n".join(context_parts)
    
    def clear_all_documents(self):
        """Clear all documents from the collection"""
        try:
            self.client.delete_collection(self.collection_name)
            self.client.create_collection(
                collection_name=self.collection_name,
                vectors_config=VectorParams(size=1536, distance=Distance.COSINE)
            )
            return True
        except Exception as e:
            print(f"Error clearing documents: {str(e)}")
            return False
    
    def get_document_count(self) -> int:
        """Get total number of chunks in the database"""
        try:
            collection_info = self.client.get_collection(self.collection_name)
            return collection_info.points_count
        except:
            return 0
    
    def get_indexed_files(self) -> List[str]:
        """Get list of indexed filenames"""
        try:
            # Scroll through all points to get unique filenames
            points, _ = self.client.scroll(
                collection_name=self.collection_name,
                limit=1000
            )
            
            filenames = set()
            for point in points:
                filenames.add(point.payload.get("filename", "Unknown"))
            
            return sorted(list(filenames))
        except:
            return []