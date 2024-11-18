# World.gd
extends "res://scripts/maps/base_scene.gd"

func _ready():
	$player.position = global.player_start_position  # Use the dynamically set start position

# Use SceneTransitionManager to handle scene transition
func _on_sacred_pond_transition_body_entered(body):
	if body.has_method("player"):
		global.transition_scene = true
		SceneTransitionManager.transition_to_scene("world", "sacred_pond")

func _on_george_washington_location_transition_body_entered(body):
	if body.has_method("player"):
		global.transition_scene = true
		SceneTransitionManager.transition_to_scene("world", "george_washington_location")
