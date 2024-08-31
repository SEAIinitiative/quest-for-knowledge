extends CharacterBody2D

# Base enemy variables
var enemy_name = "enemy"
var speed = 10
var player_chase = false
var player = null
var health = 100
var player_inattack_range = false
var can_take_damage = true
var damage = 20  # Default damage value, can be overridden by specific enemies

# Function called every physics frame
func _physics_process(delta):
	chase_player(delta)
	update_health()
	update_animation()

# Placeholder function for enemy-related methods
func enemy():
	pass

# Function to chase the player
func chase_player(delta):
	var movement = Vector2.ZERO
	if player_chase == true:
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

# Function to handle the player etering the detection area
func _on_detection_area_body_entered(body):
	if body.has_method("player"):
		player = body
		player_chase = true

# Function to handle the player exiting the detection area
func _on_detection_area_body_exited(body):
	if body.has_method("player"):
		player = null
		player_chase = false

# Function to update animations based on movement and state
func update_animation():
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

# Function to handle the player entering the enemy's hitbox
func _on_enemy_hitbox_body_entered(body):
	if body.has_method("player"):
		player_inattack_range = true

# Function to handle the player exiting the enemy's hitbox
func _on_enemy_hitbox_body_exited(body):
	if body.has_method("player"):
		player_inattack_range = false

# Function to attack the player
func attack_player():
	if player_inattack_range:
		player.take_damage(damage)  # Assuming player has a take_damage method (SET THIS UP PRONTO!!!!!)

# Function to handle taking damage
func take_damage(amount):
	health -= amount
	if health <= 0:
		queue_free()

# Function called when the take damage cooldown timer finishes
func _on_take_damage_cooldown_timeout():
	can_take_damage = true

# Function to update the health bar display
func update_health():
	var healthbar = $healthbar
	healthbar.value = health
	
	if health >= 100:
		healthbar.visible = false
	else:
		healthbar.visible = true

# Function to regenerate health
func _on_regen_timeout():
	if health < 60:
		health = health + 10
		if health >= 60:
			health = 60
	if health <= 0:
		health = 0

