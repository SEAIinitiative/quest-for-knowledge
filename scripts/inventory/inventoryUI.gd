extends Control

var inventory_script

# Connect this UI to the inventory backend
func _ready():
	inventory_script = get_node("/root/Inventory")

# Populate the inventory UI
func update_inventory():
	var grid = $GridContainer
	grid.clear()  # Clear existing items
	for item_id in inventory_script.inventory:
		var item = inventory_script.item_database[item_id]
		var icon = preload("res://scenes/inventory/items/base_item.tscn")
		var button = TextureButton.new()
		button.texture_normal = icon
		button.connect("pressed", Callable(self, "_on_item_pressed").bind(item_id))
		grid.add_child(button)

# Handle item selectionS
func _on_item_pressed(item_id):
	var item = inventory_script.item_database[item_id]
	$Label.text = item["name"] + ": " + item["description"]

# Use the selected item
func _on_use_button_pressed():
	var selected_item_id = $Label.text.split(":")[0]
	var result = inventory_script.use_item(selected_item_id)
	print(result)
	update_inventory()

# Close inventory
func _on_close_button_pressed():
	self.hide()
