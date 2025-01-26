extends Node3D

const explosion_duration = .5
var mi:MeshInstance3D
var final_size = Vector3.ONE * 2

func _ready():
	mi = $RigidBody3D/MeshInstance3D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	mi.scale_object_local(lerp(scale, final_size, delta / explosion_duration))
	var mat: BaseMaterial3D = mi.get_active_material(0)
	mat.albedo_color.a = lerp(mat.albedo_color.a, 0.0, delta / explosion_duration)
	if mi.scale >= final_size:
		queue_free()


func on_explosion_hit(body: Node3D) -> void:
	if body.get_meta("explodable", false):
		body.destroy()
