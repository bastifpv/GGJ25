extends Node3D

@export var bubbleColor: Color

# Called when the node enters the scene tree for the first time.
func _ready():
	var material = $BubbleMesh.get_active_material(0)
	material.set_shader_parameter("bubble_color", bubbleColor)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
