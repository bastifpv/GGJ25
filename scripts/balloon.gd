extends RigidBody3D

@export var default_size = .2
var size: float = default_size
var type: String = "o2"
var ctrl: MarginContainer

func set_color(col: Color):
	var mesh: MeshInstance3D = $baloon.get_children()[0]
	if mesh && mesh.get_active_material(0):
		var new_mat = mesh.get_active_material(0).duplicate()
		new_mat.albedo_color = col
		mesh.material_override = new_mat

func update_size():
	gravity_scale = -1 * size
	$CollisionShape3D.scale = Vector3.ONE * size
	$baloon.scale = Vector3.ONE * size
	$CollisionShape3D.position = Vector3(0, size * .75, 0)

func reset():
	size = default_size
	update_size()

func disable():
	hide()
	$CollisionShape3D.disabled = true
	set_process(false)

func enable():
	show()
	$CollisionShape3D.disabled = false
	set_process(true)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ctrl = get_node("/root/Node3D/Control/MarginContainer")
	#$CollisionShape3D/Rope.bottom_point = get_node("/root/Node3D/PlayerRig/Player")
	match name:
		"Balloon":
			set_color(Color.MEDIUM_BLUE)
		"Balloon_2":
			disable()
			set_color(Color.FIREBRICK)
			type = "h2"
		"Balloon_3":
			disable()
			set_color(Color.DARK_GREEN)
			type = "n2"
	#$CollisionShape3D/Rope.init()
	update_size()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	return

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("spikey"):
		AudioManager.play_boom()
		reset()
		ctrl.oneForMe(type, -ctrl.tank[type])
