extends RigidBody2D

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var ray_cast_2d = $RayCast2D

var MOVE_SPEED = 4000
var MAX_SPEED = 4000
var JUMP_FORCE = -2000

func _physics_process(delta):
	var direction = Input.get_axis("ui_left", "ui_right")
	var current_velocity = Vector2(0,0) 
	var jump = Vector2(0,0)
	linear_damp = 4
	
	if (Input.is_action_pressed("ui_left")):
		current_velocity -= Vector2(MOVE_SPEED,0)
	elif (Input.is_action_pressed("ui_right")):
		current_velocity += Vector2(MOVE_SPEED,0)
	else: current_velocity = Vector2.ZERO
	
	if (Input.is_action_pressed("ui_up")) and _on_floor():
		jump += Vector2(0,JUMP_FORCE) 
	#if not _on_floor():
	#	linear_damp = 0
	if linear_velocity.y > 0 :
		linear_damp = 0
	else:
		linear_damp = 4
	
	_set_animation(direction)
	apply_central_impulse(jump)
	apply_central_force(current_velocity)
	
func _integrate_forces(state):
		rotation_degrees = 0
	
func _set_animation(direction):
	
	if direction > 0: animated_sprite_2d.flip_h = false
	elif direction < 0: animated_sprite_2d.flip_h = true
	
	if not _on_floor(): animated_sprite_2d.play("jump")
	elif abs(linear_velocity.x) > 0.1: animated_sprite_2d.play("walk")
	else: animated_sprite_2d.play("idle")
	
	
func _on_floor():
	if ray_cast_2d.is_colliding(): return true
