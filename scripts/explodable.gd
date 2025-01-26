extends StaticBody3D

var soft_mat = preload("res://materials/sandstone.tres")
var destroying = false

var mesh: MeshInstance3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mesh = get_mesh()
	mesh.material_override = soft_mat
	set_meta("explodable", true)
	set_collision_layer_value(5, true)

func destroy():
	destroying = true
	for coll in get_colliders():
		coll.queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if destroying:
		mesh.transparency = lerp(mesh.transparency, 1.0, delta * 5.0)
		if mesh.transparency == 0.0:
			get_parent().destroy()

func get_mesh():
	for child in get_children():
		if child is MeshInstance3D:
			return child

func get_colliders():
	var colliders = []
	for child in get_children():
		if child is CollisionShape3D:
			colliders.append(child)
	return colliders
