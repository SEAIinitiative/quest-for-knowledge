extends CharacterBody2D

#Variables for player
var health = 100
var player_alive = true
var attack_ip = false # Is player in the middle of an attack?
const speed = 51 # Movement speed of the player
var current_dir = "none" # Direction of the player movement


# Variables for attack cooldown
var can_attack = true

# Variables for enemy interactions
var current_enemy = null
var enemy_inattack_range = false
var enemy_attack_cooldown = true

# Function called when the node is added to the scene
func _ready():
	$AnimatedSprite2D.play("front_idle") # Set initial animation to idle 

# Function called every physics frame
func _physics_process(delta):
	player_movement(delta) # Handle player movement
	enemy_attack() # Handle enemy attacks
	attack() # Handle player attacks
	current_camera() # Update camera based on current scene
	update_health() # Update health display

# Function to handle player movement
func player_movement(delta):
	
	if Input.is_action_pressed("ui_right"):
		current_dir = "right"
		play_anim(1)
		velocity.x = speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_left"):
		current_dir = "left"
		play_anim(1)
		velocity.x = -speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_down"):
		current_dir = "down"
		play_anim(1)
		velocity.x = 0
		velocity.y = speed
	elif Input.is_action_pressed("ui_up"):
		current_dir = "up"
		play_anim(1)
		velocity.x = 0
		velocity.y = -speed
	else:
		play_anim(0)
		velocity.x = 0
		velocity.y = 0
		
	move_and_slide() # Move the player using the calculated velocity

# Function to handle animation based on movement and direction
func play_anim(movement):
	var dir = current_dir
	var anim = $AnimatedSprite2D
	
	if dir == "right":
		anim.flip_h = false
		if movement ==  1:
			if global.player_current_attack == true: #checks for attack
				anim.play("side_attack") #continues attack animation while moving
			else:
				anim.play("side_walk")
		elif movement == 0:
			if attack_ip == false:
				anim.play("side_idle")
	if dir == "left":
		anim.flip_h = true
		if movement ==  1:
			if global.player_current_attack == true: #checks for attack
				anim.play("side_attack") #continues attack animation while moving
			else:
				anim.play("side_walk")
		elif movement == 0:
			if attack_ip == false:
				anim.play("side_idle")
	if dir == "down":
		anim.flip_h = true
		if movement ==  1:
			if global.player_current_attack == true: #checks for attack
				anim.play("front_attack") #continues attack animation while moving
			else:
				anim.play("front_walk")
		elif movement == 0:
			if attack_ip == false:
				anim.play("front_idle")
	if dir == "up":
		anim.flip_h = true
		if movement ==  1:
			if global.player_current_attack == true: #checks for attack
				anim.play("back_attack") #continues attack animation while moving
			else:
				anim.play("back_walk")
		elif movement == 0:
			if attack_ip == false:
				anim.play("back_idle")

# Placeholder function for player-related methods
func player():
	pass

# Function called when another body enters the player's hitbox
func _on_player_hitbox_body_entered(body):
	if body.has_method("enemy"):
		enemy_inattack_range = true
		current_enemy = body

# Function called when another body exits the player's hitbox
func _on_player_hitbox_body_exited(body):
	if body.has_method("enemy"):
		enemy_inattack_range = false
		current_enemy = null

# Function to handle enemy attacks
func enemy_attack():
	if enemy_inattack_range and enemy_attack_cooldown == true:
		health = health - 20
		enemy_attack_cooldown = false
		$attack_cooldown.start() # Start cooldown timer for next attack
		print(health)

# Function called when the attack cooldown timer finishes
func _on_attack_cooldown_timeout():
	enemy_attack_cooldown = true

# Function to handle player attacks
func attack():
	var dir = current_dir
	
	if Input.is_action_just_pressed("attack") and can_attack == true:
		global.player_current_attack = true
		attack_ip = true
		can_attack = false
		if enemy_inattack_range == true:
			if enemy_inattack_range and current_enemy:
				if current_enemy.has_method("take_damage"):
					current_enemy.take_damage(20)  # Deal 20 damage to the enemy
		if dir == "right":
			$AnimatedSprite2D.flip_h = false
			$AnimatedSprite2D.play("side_attack")
			$deal_attack_timer.start()
		if dir == "left":
			$AnimatedSprite2D.flip_h = true
			$AnimatedSprite2D.play("side_attack")
			$deal_attack_timer.start()
		if dir == "down":
			$AnimatedSprite2D.play("front_attack")
			$deal_attack_timer.start()
		if dir == "up":
			$AnimatedSprite2D.play("back_attack")
			$deal_attack_timer.start()

# Function called when the deal attack timer finishes
func _on_deal_attack_timer_timeout():
	$deal_attack_timer.stop()
	global.player_current_attack = false
	attack_ip = false
	can_attack = true

# Function to update the camera based on the current scene
func current_camera():
	if global.current_scene == "world":
		$world_camera.enabled = true
		$sacred_pond_camera.enabled = false
	elif global.current_scene == "sacred_pond":
		$world_camera.enabled = false
		$sacred_pond_camera.enabled = true

# Function to update the health bar display
func update_health():
	var healthbar = $healthbar
	healthbar.value = health
	
	if health >= 100:
		healthbar.visible = false
	else:
		healthbar.visible = true

# Check if player health is depleted
	if health <= 0:
		player_alive = false
		health = 0
		print("Defeated")
		self.queue_free() # Remove player from the scene

# Function called when the regen timer finishes
func _on_regen_timer_timeout():
	if health < 100:
		health = health + 20
		if health >= 100:
			health = 100
	if health <= 0:
		health = 0
		
