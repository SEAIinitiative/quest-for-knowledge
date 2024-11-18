extends Node2D

# Set player position based on transition data, editor placement, or default load position
func _ready():
	if global.first_game_load:
		$player.position = global.default_start_position
		global.first_game_load = false  # Reset to mark that first load is complete
	elif global.transition_scene:
		set_player_position()
	else:
		global.transition_scene = false  # Reset the transition state if no transition

	# Reset the transition flag after setting the position to prevent immediate re-transitioning
	global.transition_scene = false

# Central method for setting player start position during transitions
func set_player_position():
	$player.position = global.player_start_position
	global.transition_scene = false  # Reset transition flag after positioning

# Scene change management - checks and transitions to specified scene
func _process(delta):
	change_scene()

func change_scene():
	if global.transition_scene:
		_transition_to_scene()

# Scene-specific transition - to be overridden in child scenes if needed
func _transition_to_scene():
	pass

# Called when an area transition body enters - toggles transition state
func _on_area_transition_body_entered(body):
	if body.has_method("player"):
		global.transition_scene = true
