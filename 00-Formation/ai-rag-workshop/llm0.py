import os
from dotenv import load_dotenv
from openai import OpenAI

load_dotenv()  # Make sure OPENROUTER_API_KEY is available

client = OpenAI(
    base_url="https://openrouter.ai/api/v1", api_key=os.getenv("OPENROUTER_API_KEY", "")
)

MODEL = "openai/gpt-4o-mini"


def chat_with_llm(messages):
    response = client.chat.completions.create(
        model=MODEL, messages=messages, temperature=0.7
    )
    return response.choices[0].message.content


if __name__ == "__main__":
    messages = [{"role": "system", "content": "You are a helpful assistant."}]
    while True:
        user_input = input("You: ")
        if user_input.lower() in ["exit", "quit"]:
            break
        messages.append({"role": "user", "content": user_input})
        reply = chat_with_llm(messages)
        print("LLM:", reply)
        messages.append({"role": "assistant", "content": reply})
