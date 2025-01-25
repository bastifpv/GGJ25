extends RigidBody3D

@export var idle_anim: String = "idle"
var ap: AnimationPlayer
var force = 1500
var targetDirection = Vector3.ZERO

func _ready():
	ap = $diver/AnimationPlayer
	ap.autoplay = idle_anim
	return

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	var add_vec = Vector3.ZERO
	targetDirection.z = 0
	var cur_anim = ap.current_animation
	var new_anim = idle_anim
	if Input.is_action_pressed("up"):
		targetDirection.z = 45
		add_vec.y += force
		new_anim = "swim"
	if Input.is_action_pressed("down"):
		targetDirection.z = -45
		add_vec.y -= force
		new_anim = "swim"
	if Input.is_action_pressed("right"):
		targetDirection.y = 0
		add_vec.x += force
		new_anim = "swim"
	if Input.is_action_pressed("left"):
		targetDirection.y = 180
		add_vec.x -= force
		new_anim = "swim"
	
	apply_central_force(add_vec * delta)
	$diver.rotation_degrees = lerp($diver.rotation_degrees, targetDirection, delta * 2)
	if new_anim != cur_anim:
		print(new_anim, cur_anim)
		ap.play(new_anim)


func _on_body_entered(body: Node) -> void:
	if !body.has_node("MeshInstance3D"):
		return
	var mesh = body.get_node("MeshInstance3D")
	if mesh && mesh.get_active_material(0):
		var rng = RandomNumberGenerator.new()
		mesh.get_active_material(0).albedo_color = Color(rng.randf(), rng.randf(), rng.randf())
