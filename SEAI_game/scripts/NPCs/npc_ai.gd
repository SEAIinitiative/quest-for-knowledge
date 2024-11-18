extends CharacterBody2D

# Optional: Set a dialog or other properties for this NPC
@export var dialog_text: String = "Hello there!"

func _ready():
	# Print the dialog or any initial behavior for when the NPC appears
	print(dialog_text)

# No movement logic needed in _physics_process since NPC should stay still
