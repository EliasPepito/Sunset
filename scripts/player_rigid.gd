extends RigidBody2D

@export var walk_speed: float = 4000
@export var jump_force: float = 3000

func _ready():
	pass 



func _process(delta: float):
	
	
	var velocity = Vector2(0,0)
	var jump = Vector2(0,0)
	
	
	if Input.is_action_pressed("ui_right"):
		velocity += Vector2(walk_speed,0)
	elif Input.is_action_pressed("ui_left"):
		velocity -= Vector2(walk_speed,0)
	else: velocity = Vector2.ZERO
	
	if Input.is_action_just_pressed("ui_up"):
		jump -= Vector2(0,jump_force)
	else: jump = Vector2.ZERO
	
	apply_central_impulse(jump)
	apply_central_force(velocity)
	
	if (velocity.x < 0):
		$AnimatedSprite2D.scale.x = -1
	else: $AnimatedSprite2D.scale.x = 1
	
