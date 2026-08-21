import time
from typing import Any, Dict, List, Optional

def get_user_data(users: List[Dict[str, Any]], user_id: int) -> Optional[Dict[str, Any]]:
    """Find a user by their ID in a list of users."""
    for u in users:
        if u.get('id') == user_id:
            return u
    return None

def process_payments(items: List[Dict[str, Any]]) -> float:
    """Calculate the total price of items including a 10% tax.
    Simulates a slow network call per item.
    """
    total = 0.0
    for i in items:
        price = i.get('price', 0.0)
        # Calculate tax (10%)
        tax = price * 0.1
        total += price + tax
        time.sleep(0.1) # Simulate slow network call
   
    return total

def run_batch() -> None:
    """Run a batch process of user lookup and payment calculation."""
    users = [{'id': 1, 'name': 'Alice'}, {'id': 2, 'name': 'Bob'}]
    items = [{'price': 10}, {'price': 20}, {'price': 100}]
   
    target_id = 3
    u = get_user_data(users, target_id)
    if u is not None:
        print(f"User found: {u['name']}")
    else:
        print(f"User with ID {target_id} not found.")
   
    total_payment = process_payments(items)
    print(f"Total: {total_payment:.2f}")

if __name__ == "__main__":
    run_batch()