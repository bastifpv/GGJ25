extends RigidBody3D

var size = .5
signal collected

func update_size():
	gravity_scale = -1 * size
	$CollisionShape3D.scale = Vector3.ONE * size
	$baloon.scale = Vector3.ONE * size

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_size()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	return


func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("bubble"):
		var add_scale = body.get_node("BubbleMesh").scale
		size += add_scale.x / 10
		body.queue_free()
		collected.emit(add_scale)
		update_size()
