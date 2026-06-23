from fastapi import FastAPI

app = FastAPI(title="Local-LM-UI")

@app.get("/")
async def root():
    return {"message": "Local-LM-UI is running!"}
