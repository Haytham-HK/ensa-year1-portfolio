import os
import requests
import smtplib
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart
from typing import Dict, List, Optional
from dotenv import load_dotenv
import re

load_dotenv()


class WebSearchTool:
    """Tool for searching the web using SerpAPI"""
    
    def __init__(self):
        self.api_key = os.getenv("SERPAPI_KEY")
        self.base_url = "https://serpapi.com/search"
    
    def search(self, query: str, num_results: int = 5) -> Dict:
        """Search the web using SerpAPI"""
        if not self.api_key:
            return {
                "success": False,
                "error": "SERPAPI_KEY not found in environment variables"
            }
        
        params = {
            "q": query,
            "api_key": self.api_key,
            "num": num_results,
            "engine": "google"
        }
        
        try:
            response = requests.get(self.base_url, params=params)
            response.raise_for_status()
            data = response.json()
            
            results = []
            if "organic_results" in data:
                for result in data["organic_results"][:num_results]:
                    results.append({
                        "title": result.get("title", ""),
                        "link": result.get("link", ""),
                        "snippet": result.get("snippet", ""),
                        "position": result.get("position", 0)
                    })
            
            return {
                "success": True,
                "query": query,
                "results": results,
                "total_results": len(results)
            }
            
        except Exception as e:
            return {
                "success": False,
                "error": f"Search error: {str(e)}"
            }
    
    def format_results(self, search_data: Dict) -> str:
        """Format search results for display"""
        if not search_data.get("success"):
            return f"❌ {search_data.get('error', 'Unknown error')}"
        
        results = search_data.get("results", [])
        if not results:
            return "No results found."
        
        formatted = f"🔍 Search Results for: '{search_data['query']}'\n\n"
        for idx, result in enumerate(results, 1):
            formatted += f"{idx}. **{result['title']}**\n"
            formatted += f"   {result['snippet']}\n"
            formatted += f"   🔗 {result['link']}\n\n"
        
        return formatted


class EmailTool:
    """Tool for sending emails using SMTP"""
    
    def __init__(self):
        self.smtp_server = os.getenv("SMTP_SERVER", "smtp.gmail.com")
        self.smtp_port = int(os.getenv("SMTP_PORT", "587"))
        self.sender_email = os.getenv("EMAIL_SENDER_ADDRESS")
        self.sender_password = os.getenv("EMAIL_SENDER_PASSWORD")
    
    def send_email(self, to_email: str, subject: str, body: str, is_html: bool = False) -> Dict:
        """Send an email using SMTP"""
        if not self.sender_email or not self.sender_password:
            return {
                "success": False,
                "error": "SENDER_EMAIL or SENDER_PASSWORD not found in environment variables"
            }
        
        try:
            message = MIMEMultipart("alternative")
            message["Subject"] = subject
            message["From"] = self.sender_email
            message["To"] = to_email
            
            mime_type = "html" if is_html else "plain"
            message.attach(MIMEText(body, mime_type))
            
            with smtplib.SMTP(self.smtp_server, self.smtp_port) as server:
                server.starttls()
                server.login(self.sender_email, self.sender_password)
                server.send_message(message)
            
            return {
                "success": True,
                "message": f"Email sent successfully to {to_email}"
            }
            
        except Exception as e:
            return {
                "success": False,
                "error": f"Email error: {str(e)}"
            }


class ToolManager:
    """Manager for all tools"""
    
    def __init__(self):
        self.web_search = WebSearchTool()
        self.email = EmailTool()
        self.tools_enabled = {
            "web_search": False,
            "email": False
        }
    
    def enable_tool(self, tool_name: str):
        """Enable a specific tool"""
        if tool_name in self.tools_enabled:
            self.tools_enabled[tool_name] = True
    
    def disable_tool(self, tool_name: str):
        """Disable a specific tool"""
        if tool_name in self.tools_enabled:
            self.tools_enabled[tool_name] = False
    
    def is_tool_enabled(self, tool_name: str) -> bool:
        """Check if a tool is enabled"""
        return self.tools_enabled.get(tool_name, False)
    
    def get_enabled_tools(self) -> List[str]:
        """Get list of enabled tools"""
        return [tool for tool, enabled in self.tools_enabled.items() if enabled]
    
    def execute_tool(self, tool_name: str, **kwargs) -> Dict:
        """Execute a tool by name"""
        if not self.is_tool_enabled(tool_name):
            return {
                "success": False,
                "error": f"Tool '{tool_name}' is not enabled"
            }
        
        if tool_name == "web_search":
            query = kwargs.get("query", "")
            num_results = kwargs.get("num_results", 5)
            return self.web_search.search(query, num_results)
        
        elif tool_name == "email":
            to_email = kwargs.get("to_email", "")
            subject = kwargs.get("subject", "")
            body = kwargs.get("body", "")
            is_html = kwargs.get("is_html", False)
            return self.email.send_email(to_email, subject, body, is_html)
        
        return {
            "success": False,
            "error": f"Unknown tool: {tool_name}"
        }
    
    def detect_tool_usage(self, user_message: str) -> Optional[Dict]:
        """Detect if user wants to use a tool"""
        message_lower = user_message.lower()
        
        # Detect web search
        search_keywords = ["search", "google", "find", "look up", "what is", "latest", "current", "news"]
        if any(keyword in message_lower for keyword in search_keywords):
            if self.is_tool_enabled("web_search"):
                return {
                    "tool": "web_search",
                    "detected": True
                }
        
        # Detect email
        email_keywords = ["send email", "email to", "send message to", "mail to"]
        if any(keyword in message_lower for keyword in email_keywords):
            if self.is_tool_enabled("email"):
                return {
                    "tool": "email",
                    "detected": True
                }
        
        return None
    
    def parse_email_request(self, user_message: str) -> Optional[Dict]:
        """Parse email request from user message"""
        # Find email address
        email_pattern = r'[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}'
        emails = re.findall(email_pattern, user_message)
        
        if not emails:
            print(f"No email found in: {user_message}")
            return None
        
        to_email = emails[0]
        
        # Extract subject
        subject = "Message from AI Assistant"
        subject_match = re.search(r'subject[\s:]+(.+?)(?:\s+saying|\s+about|$)', user_message, re.IGNORECASE)
        if subject_match:
            subject = subject_match.group(1).strip()
        
        # Extract body
        body = ""
        
        # Try to find content after "saying", "about", or ":"
        if "saying" in user_message.lower():
            body_match = re.search(r'saying\s+(.+)', user_message, re.IGNORECASE)
            if body_match:
                body = body_match.group(1).strip()
        
        elif "about" in user_message.lower():
            body_match = re.search(r'about\s+(.+?)(?:\s+subject|$)', user_message, re.IGNORECASE)
            if body_match:
                body = body_match.group(1).strip()
        
        elif ":" in user_message:
            parts = user_message.split(":", 1)
            if len(parts) > 1:
                body = parts[1].strip()
        
        # Fallback: use everything after email
        if not body:
            after_email = user_message.split(to_email, 1)
            if len(after_email) > 1:
                body = after_email[1].strip()
                # Remove common words
                body = re.sub(r'^(saying|about|that|to say)\s+', '', body, flags=re.IGNORECASE)
        
        if not body:
            body = "Hello, this is a message from the AI assistant."
        
        print(f"Parsed email - To: {to_email}, Subject: {subject}, Body: {body[:30]}...")
        
        return {
            "to_email": to_email,
            "subject": subject,
            "body": body
        }