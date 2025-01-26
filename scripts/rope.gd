extends Node3D

@export var subdivisions: int = 6
@export var top_point: PhysicsBody3D
@export var bottom_point: PhysicsBody3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$TopJoint.node_a = top_point.get_path()
	$BottomJoint.node_b = bottom_point.get_path()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
