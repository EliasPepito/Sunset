extends CharacterBody2D


var SPEED = 600.0
var SPRINT_SPEED = 1500.0
const JUMP_VELOCITY = -1550.0
var facing_right = true
var can_jump_again = true
@onready var animated_sprite = $AnimatedSprite2D

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	if Input.is_action_just_pressed("ui_up") and can_jump_again and not is_on_floor():
		velocity.y = JUMP_VELOCITY
		can_jump_again = false
	if is_on_floor() and not can_jump_again:
		can_jump_again = true
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if Input.is_action_pressed("sprint") and direction:
		velocity.x = direction * SPRINT_SPEED
	
	if (facing_right and velocity.x < 0) or (not facing_right and velocity.x > 0):
		scale.x *= -1
		facing_right = not facing_right
	
	update_anim()
	move_and_slide()

func update_anim():
	
	var is_running = false
	if not is_on_floor():
		if velocity.y < 0:
			animated_sprite.play("jump")
		elif velocity.y > 0:
			animated_sprite.play("fall")
		return
		
	if (velocity.x >= 1000.0) or (velocity.x <= -1000.0):
		is_running = true
	else: is_running = false 
	if (velocity.x and velocity.x <= 400.0) or (velocity.x and velocity.x >= -400.0):
		animated_sprite.play("walk")
	else:
		animated_sprite.play("idle")
	if (is_running):
		animated_sprite.play("run")
