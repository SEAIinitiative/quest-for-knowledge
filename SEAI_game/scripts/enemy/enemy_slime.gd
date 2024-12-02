extends "res://scripts/enemy/enemy.gd"  # Path to your base enemy script

func _ready():
	# Set unique properties for the Slime
	enemy_name = "Slime"
	health = 100
	speed = 10

# Custom Slime behavior, if any
func player_attack():
	if player_inattack_range and global.player_current_attack:
		if can_take_damage:
			health -= 20
			$take_damage_cooldown.start()
			can_take_damage = false
			print("Slime health =", health)
			if health <= 0:
				queue_free()

# You can override or extend other methods if needed
