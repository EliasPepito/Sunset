extends Camera2D

const ZOOM_SPEED = 5.0
const ZOOM_SPRINT = Vector2(0.36, 0.36)  # Zoom cuando corre
const ZOOM_NORMAL = Vector2(0.53, 0.53)  # Zoom normal

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var target_zoom = ZOOM_NORMAL  # Zoom por defecto
	
	if Input.is_action_pressed("sprint") and (Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right")) :
		target_zoom = ZOOM_SPRINT
	zoom = zoom.lerp(target_zoom, ZOOM_SPEED * delta)
	
	
