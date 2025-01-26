extends Node3D
var dir
var speed = 0.004
@export var player : Node3D
var f
# Called when the node enters the scene tree for the first time.
func _ready() -> void:	
	f = $Armature/Skeleton3D/Fishy
	$AnimationPlayer.play("swim")
	speed = randf_range(-1,1)
	if speed < 0:
		f.scale.y *= -1
		f.scale.z *= -1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	f.global_position.x += speed*delta
	
	pass
