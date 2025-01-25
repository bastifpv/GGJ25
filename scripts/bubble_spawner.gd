extends MeshInstance3D

@export var type: String = ""

var bubble = preload("res://scenes/bubble.tscn")
var rng = RandomNumberGenerator.new()
@export var player : Node3D

const bubble_color = {
	"o2": Color.MEDIUM_BLUE,
	"h2": Color.FIREBRICK,
	"n2": Color.DARK_GREEN,
}

func spawnBubble():
	var bub: RigidBody3D =  bubble.instantiate()
	bub.bubbleColor = bubble_color[type]
	add_child(bub)
	var scl = Vector3.ONE * rng.randf_range(0.01, 0.4)
	bub.gravity_scale *= scl.x
	bub.get_node("BubbleMesh").scale = scl
	bub.get_node("BubbleShape").scale = scl
	bub.global_position = global_position + Vector3(rng.randf_range(-0.1, 0.1), rng.randf_range(-0.1, 0.1), rng.randf_range(-0.1, 0.1))

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if rng.randf() > .95:
		spawnBubble()
