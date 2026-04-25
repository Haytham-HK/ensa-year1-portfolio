from fastapi import FastAPI
from pydantic import BaseModel

app = FastAPI()

class IncidentDescription(BaseModel):
    text: str

@app.post("/predict-priority")
def predict(description: IncidentDescription):
    # This is where your Scikit-learn model would go
    # For now, we use simple logic to prove the microservice works
    text = description.text.lower()
    
    if "fire" in text or "urgent" in text or "critical" in text:
        return {"priority": "URGENT"}
    elif "slow" in text or "issue" in text:
        return {"priority": "MEDIUM"}
    else:
        return {"priority": "LOW"}