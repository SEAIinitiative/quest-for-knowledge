# SceneTransitionManager.gd
extends Node

var transition_data = {
	"world_to_sacred_pond": {
		"target_scene": "res://scenes/maps/sacred_pond.tscn",
		"entry_position": Vector2(207, 185)
	},
	"world_to_george_washington_location": {
		"target_scene": "res://scenes/maps/george_washington_location.tscn",
		"entry_position": Vector2(207, 185)
	},
	"sacred_pond_to_world": {
		"target_scene": "res://scenes/maps/world.tscn",
		"entry_position": Vector2(200, 10)
	},
	"george_washington_location_to_world": {
		"target_scene": "res://scenes/maps/world.tscn",
		"entry_position": Vector2(200, 10)
	}
}

func transition_to_scene(from_scene: String, to_scene: String):
	var key = from_scene + "_to_" + to_scene
	if transition_data.has(key):
		global.current_scene = to_scene
		get_tree().change_scene_to_file(transition_data[key]["target_scene"])  # Use change_scene_to_file
		global.player_start_position = transition_data[key]["entry_position"]
		global.transition_scene = true  # Set transition flag to signal positioning
	else:
		print("Transition data not defined for: " + key)
