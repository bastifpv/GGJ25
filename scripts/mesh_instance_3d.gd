extends MeshInstance3D

var bubble = preload("res://scene/bubble.tscn")
var rng = RandomNumberGenerator.new()

func spawnBubble():
	var bub: RigidBody3D =  bubble.instantiate()
	bub.bubbleColor = Color.MIDNIGHT_BLUE
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
