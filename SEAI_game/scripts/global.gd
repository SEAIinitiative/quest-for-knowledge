# global.gd
extends Node

var player_current_attack = false
var current_scene = "world"
var transition_scene = false
var game_load = true

# General-purpose entry position, set dynamically for each transition
var player_start_position = Vector2(25, 75)

func finish_change_scene():
	if transition_scene == true:
		transition_scene = false
		if current_scene == "world":
			current_scene = "sacred_pond"
		elif current_scene == "sacred_pond":
			current_scene = "world"
