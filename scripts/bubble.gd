@tool
class_name Bubble extends Node3D

@export var bubbleColor: Color :
	get:
		return bubbleColor
	set(value):
		bubbleColor = value
		if has_node("BubbleMesh"):
			_setBubbleColor(value)

# Called when the node enters the scene tree for the first time.
func _ready():
	_setBubbleColor(bubbleColor)

func _setBubbleColor(color: Color):
	$BubbleMesh.set_instance_shader_parameter("bubble_color", color)
	#var material = $BubbleMesh.get_active_material(0)
	#material.set_shader_parameter("bubble_color", color)
