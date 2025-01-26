class_name Bubble extends Node3D

var lifetime: float = 0.0
var elapsed_time: float = 0.0
@export var min_lifetime: float = 2.0
@export var max_lifetime: float = 10.0
@export var bubbleColor: Color :
	get:
		return bubbleColor
	set(value):
		bubbleColor = value
		if has_node("BubbleMesh"):
			_setBubbleColor(value)

# Called when the node enters the scene tree for the first time.
func _ready():
	lifetime = randf_range(min_lifetime, max_lifetime)
	_setBubbleColor(bubbleColor)

func _setBubbleColor(color: Color):
	$BubbleMesh.set_instance_shader_parameter("bubble_color", color)

func _process(delta: float) -> void:
	elapsed_time += delta
	if elapsed_time >=lifetime:
			queue_free()
