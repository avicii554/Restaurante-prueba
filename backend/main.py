from fastapi import FastAPI

app = FastAPI()

@app.get("/")
def read_root():
    return {"mensaje": "¡Backend corriendo con éxito para el restaurante!"}

@app.get("/items")
def get_items():
    # Esto simula lo que Flutter va a pedir (las 2 hamburguesas y el refresco)
    return {
        "hamburguesas": 2,
        "refresco": 1,
        "estado": "pendiente"
    }