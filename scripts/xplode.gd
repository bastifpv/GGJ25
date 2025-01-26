extends Node3D

const explosion_duration = .5
var mi:MeshInstance3D

func _ready():
	mi = $RigidBody3D/MeshInstance3D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	mi.scale_object_local(lerp(scale, Vector3(5,5,5), delta / explosion_duration))
	var mat: BaseMaterial3D = mi.get_active_material(0)
	mat.albedo_color.a = lerp(mat.albedo_color.a, 0.0, delta / explosion_duration)
	if mi.scale >= Vector3(5,5,5):
		queue_free()


func on_explosion_hit(body: Node) -> void:
	print(body.name, " hit by explosion")
	if body.get_meta("explodable", false):
		print(body.name, " hit by explosion")
