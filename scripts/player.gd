extends RigidBody3D

var force = 1500

func _ready():
	return

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
	if !body.has_node("MeshInstance3D"):
		return
	var mesh = body.get_node("MeshInstance3D")
	if mesh && mesh.get_active_material(0):
		var rng = RandomNumberGenerator.new()
		mesh.get_active_material(0).albedo_color = Color(rng.randf(), rng.randf(), rng.randf())
