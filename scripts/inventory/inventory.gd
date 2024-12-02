extends Node

# Inventory data structure
var inventory = {}

# Item structure example
var item_database = {
	"health_potion": {
		"name": "Health Potion",
		"description": "Restores 50 HP",
		"type": "consumable",
		"effect": 50,
		"icon_path": "res://assets/icons/health_potion.png"
	},
	"key_of_knowledge": {
		"name": "Key of Knowledge",
		"description": "Unlocks the Library Gate",
		"type": "key_item",
		"icon_path": "res://assets/icons/key_of_knowledge.png"
	}
}

# Add item to inventory
func add_item(item_id: String, quantity: int = 1):
	if item_id in inventory:
		inventory[item_id] += quantity
	else:
		inventory[item_id] = quantity

# Remove item from inventory
func remove_item(item_id: String, quantity: int = 1):
	if item_id in inventory:
		inventory[item_id] -= quantity
		if inventory[item_id] <= 0:
			inventory.erase(item_id)

# Use an item
func use_item(item_id: String) -> String:
	if item_id in inventory and inventory[item_id] > 0:
		var item = item_database[item_id]
		if item["type"] == "consumable":
			# Example: Apply healing effect
			apply_effect(item["effect"])
			remove_item(item_id)
			return "Used " + item["name"]
	return "Cannot use item."

# Apply item effect (placeholder for actual logic)
func apply_effect(effect_value: int):
	print("Effect applied: ", effect_value)

# Display inventory contents (for debugging)
func display_inventory():
	for item_id in inventory:
		print(item_id, ": ", inventory[item_id], "x")
