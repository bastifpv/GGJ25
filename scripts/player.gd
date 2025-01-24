extends RigidBody3D

var force = 1500

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
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


func _on_body_entered(body: Node) -> void:
	var mesh: MeshInstance3D = body.get_node("MeshInstance3D")
	if mesh.get_active_material(0):
		var rng = RandomNumberGenerator.new()
		mesh.get_active_material(0).albedo_color = Color(rng.randf(), rng.randf(), rng.randf())
