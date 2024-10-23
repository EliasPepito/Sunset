extends RigidBody2D
class_name PlayerController
## A CharacterBody2D that takes user input to make player actions.

#region Export Variables
## Player Walking speed
@export var player_speed : int = 100 
## Player Sprint speed
@export var player_sprint_speed : int = 100
#endregion

#region Variables
var player_direction : Vector2 = Vector2.ZERO
const JUMP_VELOCITY = -1550.0
var facing_right = true
var can_jump_again = true
@onready var animated_sprite = $AnimatedSprite2D
#endregion

func _physics_process(delta):
	
	player_direction = Input.get_vector("ui_left", "ui_right","ui_up", "ui_down")
	
	move_player(player_direction, delta)
	
	## Add the gravity.
	#if not is_on_floor():
		#velocity += get_gravity() * delta
#
	## Handle jump.
	#if Input.is_action_just_pressed("ui_up") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
	#
	#if Input.is_action_just_pressed("ui_up") and can_jump_again and not is_on_floor():
		#velocity.y = JUMP_VELOCITY
		#can_jump_again = false
	#if is_on_floor() and not can_jump_again:
		#can_jump_again = true
	#
	## Get the input direction and handle the movement/deceleration.
	## As good practice, you should replace UI actions with custom gameplay actions.
	#var direction = Input.get_axis("ui_left", "ui_right")
	#if direction:
		#velocity.x = (direction * SPEED) * delta
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
	#
	#if Input.is_action_pressed("sprint") and direction:
		#velocity.x = direction * SPRINT_SPEED
	#
	#if (facing_right and velocity.x < 0) or (not facing_right and velocity.x > 0):
		#scale.x *= -1
		#facing_right = not facing_right
	
	#update_anim()

#func update_anim():
	
	#var is_running = false
	#if not is_on_floor():
		#if velocity.y < 0:
			#animated_sprite.play("jump")
		#elif velocity.y > 0:
			#animated_sprite.play("fall")
		#return
		#
	#if (velocity.x >= 1000.0) or (velocity.x <= -1000.0):
		#is_running = true
	#else: is_running = false 
	#if (velocity.x and velocity.x <= 400.0) or (velocity.x and velocity.x >= -400.0):
		#animated_sprite.play("walk")
	#else:
		#animated_sprite.play("idle")
	#if (is_running):
		#animated_sprite.play("run")

func move_player(player_direction : Vector2, delta : float):
	
	if (player_direction.x != 0):
		linear_velocity.x = (player_direction.x * player_speed) * delta * 1000
	else:
		linear_velocity.x = move_toward(linear_velocity.x, 0, player_speed)
	
	#if Input.is_action_pressed("sprint") and direction:
		#velocity.x = direction * SPRINT_SPEED
	
	if (facing_right and linear_velocity.x < 0) or (not facing_right and linear_velocity.x > 0):
		$AnimatedSprite2D.scale.x *= -1
		facing_right = not facing_right
