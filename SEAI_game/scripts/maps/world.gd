extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	# Player spawn location
	if global.game_load == true:
		$player.position.x = global.player_start_posx
		$player.position.y = global.player_start_posy
	else:
		$player.position.x = global.player_exit_sacred_pond_posx
		$player.position.y = global.player_exit_sacred_pond_posy


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	change_scene()


func _on_sacred_pond_transition_body_entered(body):
	if body.has_method("player"):
		global.transition_scene = true


func change_scene():
	if global.transition_scene == true:
		if global.current_scene == "world":
			get_tree().change_scene_to_file("res://scenes/maps/sacred_pond.tscn")
			global.game_load = false
			global.finish_change_scene()
		
