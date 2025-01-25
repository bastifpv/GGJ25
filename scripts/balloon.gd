extends RigidBody3D

@export var default_size = .2
var size: float = default_size

func update_size():
	gravity_scale = -1 * (size + 1)
	$CollisionShape3D.scale = Vector3.ONE * size
	$baloon.scale = Vector3.ONE * size

func reset():
	size = default_size
	update_size()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_size()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	return
