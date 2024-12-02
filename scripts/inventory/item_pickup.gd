extends Area2D

var item_id = "health_potion"

func _on_body_entered(body):
	if body.name == "Player":
		var inventory_script = get_node("res://scripts/inventory/inventory.gd")
		inventory_script.add_item(item_id)
		queue_free()  # Remove item from world
