import streamlit as st
import requests
from qdrant_client import QdrantClient
from qdrant_client.models import Distance, VectorParams, PointStruct
import uuid
from datetime import datetime
import os
from dotenv import load_dotenv
from rag import RAGSystem
from tools import ToolManager

# Load environment variables
load_dotenv()

# Configuration
st.set_page_config(page_title="AI Chatbot with RAG & Tools", page_icon="💬", layout="centered")

# Get API key from environment
OPENROUTER_API_KEY = os.getenv("OPENROUTER_API_KEY")

# Initialize session state
if "messages" not in st.session_state:
    st.session_state.messages = []

if "qdrant_client" not in st.session_state:
    # Initialize Qdrant client (in-memory for now)
    st.session_state.qdrant_client = QdrantClient(":memory:")
    
    # Create collection for chat history
    st.session_state.qdrant_client.create_collection(
        collection_name="chat_memory",
        vectors_config=VectorParams(size=1536, distance=Distance.COSINE)
    )

if "rag_system" not in st.session_state:
    st.session_state.rag_system = RAGSystem(st.session_state.qdrant_client)

if "tool_manager" not in st.session_state:
    st.session_state.tool_manager = ToolManager()

if "use_rag" not in st.session_state:
    st.session_state.use_rag = False

# Sidebar
with st.sidebar:
    st.title("⚙️ Settings")
    
    # Model Selection
    st.subheader("🤖 Model Selection")
    model = st.selectbox(
        "Choose Model",
        [
            "anthropic/claude-3.5-sonnet",
            "openai/gpt-4-turbo",
            "openai/gpt-3.5-turbo",
            "meta-llama/llama-3.1-70b-instruct"
        ]
    )
    
    st.divider()
    
    # RAG Settings
    st.subheader("📚 RAG System")
    st.session_state.use_rag = st.checkbox("Enable RAG", value=st.session_state.use_rag)
    
    # Document Upload
    with st.expander("📄 Document Management", expanded=False):
        uploaded_file = st.file_uploader(
            "Upload Document",
            type=["txt", "md", "pdf"],
            help="Upload documents to index for RAG"
        )
        
        if uploaded_file is not None:
            if st.button("Index Document"):
                with st.spinner("Indexing document..."):
                    try:
                        # Read file content
                        if uploaded_file.type == "application/pdf":
                            content = st.session_state.rag_system.extract_text_from_pdf(uploaded_file)
                        else:
                            content = uploaded_file.read().decode("utf-8")
                        
                        chunks_count = st.session_state.rag_system.index_document(
                            text=content,
                            filename=uploaded_file.name
                        )
                        st.success(f"✅ Indexed {uploaded_file.name} ({chunks_count} chunks)")
                    except Exception as e:
                        st.error(f"Error indexing document: {str(e)}")
        
        # Document Statistics
        doc_count = st.session_state.rag_system.get_document_count()
        st.metric("Total Chunks", doc_count)
        
        # Show indexed files
        if doc_count > 0:
            st.caption("**Indexed Files:**")
            files = st.session_state.rag_system.get_indexed_files()
            for file in files:
                st.caption(f"📄 {file}")
        
        # Clear Documents Button
        if st.button("🗑️ Clear All Documents", type="secondary"):
            if st.session_state.rag_system.clear_all_documents():
                st.success("All documents cleared!")
                st.rerun()
            else:
                st.error("Error clearing documents")
    
    st.divider()
    
    # Tools Settings
    st.subheader("🛠️ AI Tools")
    
    # Web Search Tool
    web_search_enabled = st.checkbox(
        "🔍 Web Search (SerpAPI)",
        value=st.session_state.tool_manager.is_tool_enabled("web_search"),
        help="Enable web search capabilities"
    )
    if web_search_enabled:
        st.session_state.tool_manager.enable_tool("web_search")
    else:
        st.session_state.tool_manager.disable_tool("web_search")
    
    # Email Tool
    email_enabled = st.checkbox(
        "📧 Email (SMTP)",
        value=st.session_state.tool_manager.is_tool_enabled("email"),
        help="Enable email sending capabilities"
    )
    if email_enabled:
        st.session_state.tool_manager.enable_tool("email")
    else:
        st.session_state.tool_manager.disable_tool("email")
    
    # Show enabled tools
    enabled_tools = st.session_state.tool_manager.get_enabled_tools()
    if enabled_tools:
        st.caption(f"**Active Tools:** {', '.join(enabled_tools)}")
    
    st.divider()
    
    # Clear Chat
    if st.button("Clear Chat History"):
        st.session_state.messages = []
        st.rerun()

# Main chat interface
st.title("💬 AI Chatbot with RAG & Tools")
st.caption("Powered by OpenRouter, Qdrant, SerpAPI & SMTP")

# Check if API key is configured
if not OPENROUTER_API_KEY:
    st.error("⚠️ OpenRouter API key not found! Please add OPENROUTER_API_KEY to your .env file")
    st.stop()

# Display chat messages
for message in st.session_state.messages:
    with st.chat_message(message["role"]):
        st.markdown(message["content"])
        if "context_used" in message and message["context_used"]:
            with st.expander("📚 Context Used"):
                st.caption(message["context_used"])
        if "tool_used" in message and message["tool_used"]:
            with st.expander("🛠️ Tool Used"):
                st.caption(message["tool_used"])

# Function to call OpenRouter API
def call_openrouter(messages, model):
    url = "https://openrouter.ai/api/v1/chat/completions"
    
    headers = {
        "Authorization": f"Bearer {OPENROUTER_API_KEY}",
        "Content-Type": "application/json"
    }
    
    data = {
        "model": model,
        "messages": messages
    }
    
    try:
        response = requests.post(url, headers=headers, json=data)
        response.raise_for_status()
        return response.json()["choices"][0]["message"]["content"]
    except Exception as e:
        return f"Error: {str(e)}"

# Function to store message in Qdrant
def store_in_qdrant(role, content):
    placeholder_vector = [0.1] * 1536
    
    point = PointStruct(
        id=str(uuid.uuid4()),
        vector=placeholder_vector,
        payload={
            "role": role,
            "content": content,
            "timestamp": datetime.now().isoformat()
        }
    )
    
    st.session_state.qdrant_client.upsert(
        collection_name="chat_memory",
        points=[point]
    )

# Chat input
if prompt := st.chat_input("Type your message here..."):
    # Add user message to chat
    st.session_state.messages.append({"role": "user", "content": prompt})
    
    with st.chat_message("user"):
        st.markdown(prompt)
    
    # Store user message in Qdrant
    store_in_qdrant("user", prompt)
    
    # Prepare messages for API
    api_messages = st.session_state.messages.copy()
    context_used = None
    tool_used = None
    response = None
    
    # Detect tool usage
    tool_detection = st.session_state.tool_manager.detect_tool_usage(prompt)
    
    # Handle Web Search
    if tool_detection and tool_detection.get("tool") == "web_search":
        with st.chat_message("assistant"):
            with st.spinner("🔍 Searching the web..."):
                search_result = st.session_state.tool_manager.execute_tool(
                    "web_search",
                    query=prompt,
                    num_results=5
                )
                if search_result.get("success"):
                    formatted_results = st.session_state.tool_manager.web_search.format_results(search_result)
                    tool_used = f"Web Search: {prompt}"
                    context_used = formatted_results
                    st.markdown("✅ Search completed! Analyzing results...")
                else:
                    st.error(f"Search failed: {search_result.get('error')}")
    
    # Handle Email Sending
    if tool_detection and tool_detection.get("tool") == "email":
        with st.chat_message("assistant"):
            with st.spinner("📧 Parsing email request..."):
                email_params = st.session_state.tool_manager.parse_email_request(prompt)
                
                if email_params:
                    # Show what we detected
                    st.info(f"📧 Sending email to: **{email_params['to_email']}**")
                    st.caption(f"Subject: {email_params['subject']}")
                    
                    # Ask AI to generate a proper email body if needed
                    email_generation_prompt = f"""
                    Based on this request: "{prompt}"
                    
                    Generate a professional email with:
                    - To: {email_params['to_email']}
                    - Subject: {email_params['subject']}
                    - Body should be professional and clear
                    
                    The user wants to say: {email_params['body']}
                    
                    Write ONLY the email body (no subject line, no greeting unless needed).
                    """
                    
                    with st.spinner("✍️ Composing email..."):
                        email_body = call_openrouter(
                            [{"role": "user", "content": email_generation_prompt}],
                            model
                        )
                        
                        st.markdown("**Email Preview:**")
                        st.text_area("Body", email_body, height=150, disabled=True, key="email_preview")
                        
                        # Send the email
                        with st.spinner("📤 Sending email..."):
                            send_result = st.session_state.tool_manager.execute_tool(
                                "email",
                                to_email=email_params['to_email'],
                                subject=email_params['subject'],
                                body=email_body
                            )
                            
                            if send_result.get("success"):
                                st.success(f"✅ {send_result.get('message')}")
                                response = f"I've successfully sent an email to {email_params['to_email']} with the subject '{email_params['subject']}'."
                                tool_used = f"Email sent to: {email_params['to_email']}"
                            else:
                                st.error(f"❌ Failed to send email: {send_result.get('error')}")
                                response = f"I encountered an error while trying to send the email: {send_result.get('error')}"
                                tool_used = f"Email failed: {send_result.get('error')}"
                else:
                    st.warning("⚠️ Could not parse email details. Please specify recipient email address.")
                    response = "I couldn't parse the email details from your request. Please include the recipient's email address and message. For example: 'send email to john@example.com saying Hello, how are you?'"
    
    # Get RAG context if enabled
    if st.session_state.use_rag and st.session_state.rag_system.get_document_count() > 0:
        rag_context = st.session_state.rag_system.get_context_for_query(prompt)
        if rag_context:
            if context_used:
                context_used = f"{context_used}\n\n{rag_context}"
            else:
                context_used = rag_context
    
    # Add context to system message if available
    if context_used:
        system_message = {
            "role": "system",
            "content": f"Use the following information to answer the user's question:\n\n{context_used}\n\nIf the information doesn't fully answer the question, you can use your general knowledge."
        }
        api_messages = [system_message] + api_messages
    
    # Get AI response (only if not already handled by email tool)
    if not (tool_detection and tool_detection.get("tool") == "email"):
        with st.chat_message("assistant"):
            with st.spinner("Thinking..."):
                response = call_openrouter(api_messages, model)
                st.markdown(response)
                
                # Show context if used
                if context_used:
                    with st.expander("📚 Context Used"):
                        st.caption(context_used)
                
                # Show tool if used
                if tool_used:
                    with st.expander("🛠️ Tool Used"):
                        st.caption(tool_used)
    
    # Add assistant response to chat
    response_data = {
        "role": "assistant",
        "content": response
    }
    if context_used:
        response_data["context_used"] = context_used
    if tool_used:
        response_data["tool_used"] = tool_used
    
    st.session_state.messages.append(response_data)
    
    # Store assistant message in Qdrant
    store_in_qdrant("assistant", response)

# Footer
st.divider()
st.caption("✨ Full-featured AI Assistant with RAG, Web Search & Email capabilities")