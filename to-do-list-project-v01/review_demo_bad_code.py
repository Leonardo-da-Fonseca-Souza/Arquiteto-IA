import asyncio
import time
from typing import Any, Dict, List, Optional

def get_user_data_optimized(users_map: Dict[int, Dict[str, Any]], user_id: int) -> Optional[Dict[str, Any]]:
    """Encontra um usuário em tempo O(1) usando um dicionário indexado."""
    return users_map.get(user_id)

async def process_payment_item(item: Dict[str, Any]) -> float:
    """Processa um único item de forma assíncrona para não bloquear a thread."""
    price = item.get('price', 0.0)
    tax = price * 0.1
    await asyncio.sleep(0.1)  # Simula chamada de rede assíncrona
    return price + tax

async def process_payments_async(items: Optional[List[Dict[str, Any]]] = None) -> float:
    """Calcula o valor total de forma concorrente."""
    if not items:
        return 0.0
    
    # Executa todas as chamadas "de rede" em paralelo
    tasks = [process_payment_item(item) for item in items]
    results = await asyncio.gather(*tasks)
    return sum(results)

async def run_batch_async() -> None:
    users = [{'id': 1, 'name': 'Alice'}, {'id': 2, 'name': 'Bob'}]
    items = [{'price': 10}, {'price': 20}, {'price': 100}]
    
    # Otimização: Indexa os usuários pelo ID
    users_map = {u['id']: u for u in users if 'id' in u}
    
    target_id = 3
    u = get_user_data_optimized(users_map, target_id)
    if u is not None:
        print(f"User found: {u['name']}")
    else:
        print(f"User with ID {target_id} not found.")
    
    start_time = time.time()
    total_payment = await process_payments_async(items)
    end_time = time.time()
    
    print(f"Total: {total_payment:.2f}")
    print(f"Tempo de execução: {end_time - start_time:.4f} segundos")

if __name__ == "__main__":
    asyncio.run(run_batch_async())
