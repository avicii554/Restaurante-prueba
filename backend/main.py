from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from backend.routes import pedidos
app = FastAPI()

# Configuración de CORS para que Flutter pueda conectarse sin bloqueos
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Permite peticiones desde cualquier lugar (ideal para desarrollo)
    allow_credentials=True,
    allow_methods=["*"],  # Permite GET, POST, PUT, DELETE, etc.
    allow_headers=["*"],  # Permite cualquier cabecera
)
app.include_router(pedidos.router)

@app.get("/")
def read_root():
    return {"mensaje": "¡Backend corriendo con éxito para el restaurante!"}

@app.get("/items")
def get_items():
    return {
        "hamburguesas": 2,
        "refresco": 1,
        "estado": "pendiente"
    }