extends Node

const PASS = " - PASS"
const FAIL = " - FAIL"

func _ready():
	# Add item that dones't exists
	if !Inventory.add_item("None", 1):
		print("AddItemNoneExistent" + PASS)
	else:
		print("AddItemNoneExistent" + FAIL)

	# Add item with no category
	if !Inventory.add_item("No Category", 1):
		print("AddItemNoCategory" + PASS)
	else:
		print("AddItemNoCategory" + FAIL)
		
	# Add item with null category
	if !Inventory.add_item("Null Category", 1):
		print("AddItemNullCategory" + PASS)
	else:
		print("AddItemNullCategory" + FAIL)
		
	# Add item with amount greater than stack size
	# Expected: add an amount up to the stack size
	Inventory.add_item("Fiber", 100)
	if Inventory.get_item_quantity("Fiber") == ItemData.get_stack_size("Fiber"):
		print("AddMoreThanStackSize" + PASS + " - Inventory: " + str(Inventory.m_inventory))
	else:
		print("AddMoreThanStackSize" + FAIL + " - Inventory: " + str(Inventory.m_inventory))
		
	# Add item with negative amount
	# Expected to not add item
	Inventory.clear_inventory()
	Inventory.add_item("Fiber", -1)
	if !Inventory.item_exists_in_inventory("Fiber", -1):
		print("AddNegativeAmount" + PASS + " - Inventory: " + str(Inventory.m_inventory))
	else:
		print("AddNegativeAmount" + FAIL + " - Inventory: " + str(Inventory.m_inventory))
		
	# Simple add item when it exists in inventory
	Inventory.clear_inventory()
	Inventory.add_item("Fiber", 1)
	if Inventory.get_item_quantity("Fiber") == 1:
		Inventory.add_item("Fiber", 1)
		if Inventory.get_item_quantity("Fiber") == 2:
			print("SimpleAddTwice" + PASS + " - Inventory: " + str(Inventory.m_inventory))
		else:
			print("SimpleAddTwice" + FAIL + " - Item did not stack - " + " Inventory: " + str(Inventory.m_inventory))
	else:
		print("SimpleAddTwice" + FAIL + " - No item was added - " + " Inventory: " + str(Inventory.m_inventory))
		
	# Add twice with when the item will go past stack size
	Inventory.clear_inventory()
	Inventory.add_item("Fiber", 98)
	if Inventory.get_item_quantity("Fiber") == 98:
		Inventory.add_item("Fiber", 100)
		if Inventory.get_item_quantity("Fiber") == 99:
			print("AddTwiceOverStack" + PASS + " - Inventory: " + str(Inventory.m_inventory))
		else:
			print("AddTwiceOverStack" + FAIL + " - Second item added wrong - " + " Inventory: " + str(Inventory.m_inventory))
	else:
		print("AddTwiceOverStack" + FAIL + " - No item was added - " + " Inventory: " + str(Inventory.m_inventory))

	



