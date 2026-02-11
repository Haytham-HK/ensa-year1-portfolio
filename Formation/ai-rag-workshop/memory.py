from qdrant_client import QdrantClient
from sentence_transformers import SentenceTransformer
from uuid import uuid4
import os

model = SentenceTransformer("all-MiniLM-L6-v2")

client = QdrantClient(
    url=os.getenv("QDRANT_URL", "http://localhost:6333")
)

COLLECTION_NAME = "chat_memory"

client.recreate_collection(
    collection_name=COLLECTION_NAME,
    vectors_config={"size": 384, "distance": "Cosine"}
)

def store_message(role, content):
    vector = model.encode(content).tolist()
    client.upsert(
        collection_name=COLLECTION_NAME,
        points=[
            {
                "id": str(uuid4()),
                "vector": vector,
                "payload": {
                    "role": role,
                    "content": content
                }
            }
        ]
    )

def get_recent_messages(limit=6):
    points = client.scroll(
        collection_name=COLLECTION_NAME,
        limit=limit
    )[0]

    messages = []
    for p in points:
        messages.append({
            "role": p.payload["role"],
            "content": p.payload["content"]
        })
    return messages
