extends Node

var player_current_attack = false

var current_scene = "world"
var transition_scene = false

var player_exit_sacred_pond_posx = 207
var player_exit_sacred_pond_posy = 11
var player_start_posx = 12
var player_start_posy = 88

var enemy_name = "enemy"

var game_load = true

func finish_change_scene():
	if transition_scene == true:
		transition_scene = false
		if current_scene == "world":
			current_scene = "sacred_pond"
		elif current_scene == "sacred_pond":
			current_scene = "world"
		else:
			current_scene = "world"
