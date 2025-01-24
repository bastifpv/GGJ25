extends MeshInstance3D

var bubble = preload("res://prefabs/bubble.tscn")
var rng = RandomNumberGenerator.new()

func spawnBubble():
	var bub: Node3D =  bubble.instantiate()
	add_child(bub)
	bub.global_position = global_position + Vector3(rng.randf_range(-0.1, 0.1), rng.randf_range(-0.1, 0.1), rng.randf_range(-0.1, 0.1))
	bub.scale -= Vector3(rng.randf(), rng.randf(), rng.randf())

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if rng.randf() > .95:
		spawnBubble()
