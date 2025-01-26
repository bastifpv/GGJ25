class_name Bubble extends Node3D

var lifetime: float = 0.0
var elapsed_time: float = 0.0
var player : Node3D
@export var min_lifetime: float = 2.0
@export var max_lifetime: float = 10.0
@export var bubbleColor: Color :
	get:
		return bubbleColor
	set(value):
		bubbleColor = value
		if has_node("BubbleMesh"):
			_setBubbleColor(value)
var rng = RandomNumberGenerator.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_node("/root/Node3D/PlayerRig/Player")
	lifetime = randf_range(min_lifetime, max_lifetime)
	_setBubbleColor(bubbleColor)

func _setBubbleColor(color: Color):
	$BubbleMesh.set_instance_shader_parameter("bubble_color", color)

func _process(delta: float) -> void:
	elapsed_time += delta
	if elapsed_time >=lifetime:
		if (player.global_position - global_position).abs() < Vector3(10,0,0): # play sound only in nearby bubbles
			AudioManager.play_plop( rng.randi_range(1,5))
		queue_free()
