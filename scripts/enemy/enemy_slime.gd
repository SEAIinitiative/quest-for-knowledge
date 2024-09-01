extends CharacterBody2D

# Variables to control enemy behavior and attributes
var health = 60
var speed = 10
var player_chase = false
var player = null


# Combat variables
var player_inattack_range = false # Indicates if the player is within attack range
var can_take_damage = true # Indicates if the enemy can currently take damage

# Function called every physics frame
func _physics_process(delta):
	player_attack() # Handle player attacks on the enemy
	update_health() # Update health display
	
	# Movement handling
	var movement = Vector2.ZERO
	if player_chase:
		# Calculate direction towards the player
		var direction = (player.position - position).normalized()
		movement = direction * speed * delta
		  
		# Perform manual collision detection
		var collision = move_and_collide(movement)
		if collision:
		# Handle collision response here if needed
			pass
	else:
		movement = Vector2.ZERO
	
	# Update enemy position 
	position += movement
	
	# Animation handling
	if player_chase:
		if abs(player.position.x - position.x) > abs(player.position.y - position.y):
			if player.position.x > position.x:
				$AnimatedSprite2D.play("side_walk")
				$AnimatedSprite2D.flip_h = false
			else:
				$AnimatedSprite2D.play("side_walk")
				$AnimatedSprite2D.flip_h = true
		else:
			if player.position.y > position.y:
				$AnimatedSprite2D.play("front_walk")
			else:
				$AnimatedSprite2D.play("back_walk")
	else:
		$AnimatedSprite2D.play("front_idle")

# Function called when another body enters the detection area
func _on_detection_area_body_entered(body):
	player = body
	player_chase = true

# Function called when another body exits the detection area
func _on_detection_area_body_exited(body):
	player = null
	player_chase = false

# Placeholder function for enemy-related methods
func enemy():
	pass

# Function called when another body enters the enemy's hitbox
func _on_enemy_hitbox_body_entered(body):
	if body.has_method("player"):
		player_inattack_range = true

# Function called when another body exits the enemy's hitbox
func _on_enemy_hitbox_body_exited(body):
	if body.has_method("player"):
		player_inattack_range = false

# Function to handle player attacks on the enemy
func player_attack():
	if player_inattack_range and global.player_current_attack == true:
		if can_take_damage == true:
			health = health - 20
			$take_damage_cooldown.start()
			can_take_damage = false
			print("slime health =", health)
			if health <= 0:
				self.queue_free()

# Function called when the take damage cooldown timer finishes
func _on_take_damage_cooldown_timeout():
	can_take_damage = true

# Function to update the health bar display
func update_health():
	var healthbar = $healthbar
	healthbar.value = health
	
	if health >= 60:
		healthbar.visible = false
	else:
		healthbar.visible = true

# Function called when the regeneration timer finishes
func _on_regen_timeout():
	if health < 60:
		health = health + 10
		if health >= 60:
			health = 60
	if health <= 0:
		health = 0
