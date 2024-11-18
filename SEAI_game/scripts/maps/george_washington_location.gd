extends "res://scripts/maps/base_scene.gd"


# Called when the node enters the scene tree for the first time.
func _ready():
	$player.position = global.player_start_position  # Use the dynamically set start position



func _on_world_transistion_body_entered(body):
	if body.has_method("player"):
		global.transition_scene = true
		SceneTransitionManager.transition_to_scene("george_washington_location", "world")
