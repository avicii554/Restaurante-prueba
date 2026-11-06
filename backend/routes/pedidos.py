from fastapi import APIRouter

# El APIRouter funciona como el urls.py / views.py combinado para este módulo
router = APIRouter(prefix="/pedidos", tags=["Pedidos"])

@router.get("/")
def listar_pedidos():
    return [
        {"id": 1, "producto": "Hamburguesa Completa", "cantidad": 2, "bebida": "Refresco"},
        {"id": 2, "producto": "Hamburguesa Simple", "cantidad": 1, "bebida": "Agua"}
    ]

@router.post("/crear")
def crear_pedido(pedido: dict):
    # Acá es donde Flutter enviará las hamburguesas más adelante
    return {"mensaje": "Pedido recibido con éxito", "datos": pedido}
