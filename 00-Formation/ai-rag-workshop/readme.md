# AI Chatbot with RAG & Tools

This project is a fully functional AI assistant built with Python and Streamlit. It integrates Retrieval-Augmented Generation (RAG) for document analysis, persistent vector memory, and external tools (Web Search & Email).

Built as part of a training session by Pr. ES.SWIDI.

## Features

- **Multi-Model Support**: Switch between Claude 3.5 Sonnet, GPT-4 Turbo, and Llama 3 via OpenRouter.
- **RAG System**: Upload PDF, TXT, or MD files to chat with your documents. The system uses Qdrant for vector storage.
- **AI Tools**:
  - **Web Search**: Real-time information retrieval using SerpAPI.
  - **Email Agent**: Send emails directly from the chat interface using SMTP.
- **Long-term Memory**: Stores chat history and context using Qdrant vector database.
- **User Interface**: Clean, interactive UI built with Streamlit.

## Project Structure

- `app.py`: Main application entry point and Streamlit UI.
- `rag.py`: Handles document processing, chunking, and embedding generation.
- `tools.py`: Contains logic for Web Search (SerpAPI) and Email (SMTP) tools.
- `memory.py`: Manages vector-based chat history.
- `llm0.py`: A simple CLI script for testing LLM connections.

## Installation & Setup

### 1. Clone the Repository and cd to the file
```bash
cd ai-rag-workshop
```

### 2. Install Dependencies
Make sure you have Python installed, then run:
```bash 
pip install -r requirements.txt
```

### 3. Configure Environment
Create a file named `.env` in the project root and add your API keys:
```bash
#LLM Provider
OPENROUTER_API_KEY=sk-or-v1-...

#Vector Database (Qdrant)
QDRANT_URL=https://... 
QDRANT_API_KEY=...

#Tools
SERPAPI_KEY=... 
EMAIL_SENDER_ADDRESS=your_email@gmail.com 
EMAIL_SENDER_PASSWORD=your_app_password 
SMTP_SERVER=smtp.gmail.com 
SMTP_PORT=587
```

### 4. Run the Application
```bash
streamlit run app.py
```
## Usage

1. **Select a Model**: Choose your preferred LLM from the sidebar.
2. **Enable RAG**: Check "Enable RAG" and upload a document to ask questions about it.
3. **Use Tools**:
   - To search: Type "Search for the latest AI news".
   - To email: Type "Send an email to user@example.com saying..."

**Student:** Haytham KENNOUZ   