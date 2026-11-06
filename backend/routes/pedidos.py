from fastapi import APIRouter, HTTPException

# El APIRouter funciona como el urls.py / views.py combinado para este módulo
router = APIRouter(prefix="/pedidos", tags=["Pedidos"])


PEDIDOS_DB = [
        {"id": 1, "producto": "Hamburguesa Completa", "cantidad": 2, "bebida": "Refresco"},
        {"id": 2, "producto": "Hamburguesa Simple", "cantidad": 1, "bebida": "Agua"}
    ]
@router.get("/")
def listar_pedidos():
    return PEDIDOS_DB

@router.post("/crear")
def crear_pedido(pedido: dict):
    # 🆔 Buscamos el ID del último elemento y le sumamos 1. 
    # Si la lista se queda vacía, arranca en 1.
    nuevo_id = PEDIDOS_DB[-1]["id"] + 1 if PEDIDOS_DB else 1
    
    # Asignamos el ID seguro al pedido
    pedido["id"] = nuevo_id
    
    PEDIDOS_DB.append(pedido)
    return {"mensaje": "Pedido recibido con éxito", "datos": pedido}

@router.delete("/borrar/{pedido_id}")
def borrar_pedido(pedido_id: int):
    # 🔍 1. Buscamos si el pedido existe en nuestra lista en memoria
    for pedido in PEDIDOS_DB:
        if pedido["id"] == pedido_id:
            # 🧼 2. Si lo encuentra, lo sacamos de la lista
            PEDIDOS_DB.remove(pedido)
            return {"mensaje": f"Pedido con ID {pedido_id} eliminado correctamente", "lista_actualizada": PEDIDOS_DB}
            
    # 🚨 3. Si recorrió toda la lista y no lo encontró, devolvemos un error 404 (No encontrado)
    raise HTTPException(status_code=404, detail=f"El pedido con ID {pedido_id} no existe")