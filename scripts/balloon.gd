extends RigidBody3D

@export var default_size = .2
var size: float = default_size

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

func reset():
	size = default_size
	update_size()

func disable():
	hide()
	set_process(false)

func enable():
	show()
	set_process(true)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
		$Rope.bottom_point = get_parent().get_node("Player")
		match name:
			"Balloon_2":
				disable()
				set_color(Color.FIREBRICK)
			"Balloon_3":
				disable()
				set_color(Color.DARK_GREEN)
		$Rope.init()
		update_size()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	return
