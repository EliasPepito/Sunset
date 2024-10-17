extends CharacterBody2D


var SPEED = 400.0
var SPRINT_SPEED = 1000.0
const JUMP_VELOCITY = -950.0
var facing_right = true
@onready var animated_sprite = $AnimatedSprite2D

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = JUMP_VELOCITY

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
	if not is_on_floor():
		if velocity.y < 0:
			animated_sprite.play("jump")
		elif velocity.y > 0:
			animated_sprite.play("fall")
		return
	if velocity.x and velocity.x <= 400.0:
		animated_sprite.play("walk")
	elif (velocity.x >= 1000.0) or (velocity.x <= -1000.0):
		animated_sprite.play("run")
	else:
		animated_sprite.play("idle")
