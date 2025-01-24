extends RigidBody3D

var force = 500

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var add_vec = Vector3.ZERO
	if Input.is_action_pressed("up"):
		add_vec.y += force
	if Input.is_action_pressed("down"):
		add_vec.y -= force
	if Input.is_action_pressed("right"):
		add_vec.x += force
	if Input.is_action_pressed("left"):
		add_vec.x -= force
	
	apply_central_force(add_vec * delta)
