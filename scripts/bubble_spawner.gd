extends Node3D

@export var type: String = ""
@export var content: float
@export_range(0.0, 1.0) var spawn_rate: float = .95

var bubble = preload("res://scenes/bubble.tscn")
var rng = RandomNumberGenerator.new()

var player : Node3D

var orig_content: float
var spawn_timer: float = 0


const bubble_color = {
	"o2": Color.MEDIUM_BLUE,
	"h2": Color.FIREBRICK,
	"n2": Color.DARK_GREEN,
}
const min_scale = .2

func spawnBubble():

	if (player.global_position - global_position).abs() < Vector3(60,60,0):
		var bub: RigidBody3D =  bubble.instantiate()
		bub.bubbleColor = bubble_color[type]
		add_child(bub)
		var scl = Vector3.ONE * rng.randf_range(0.01, 0.4)
		bub.gravity_scale *= scl.x
		bub.get_node("BubbleMesh").scale = scl
		bub.get_node("BubbleShape").scale = scl
		bub.global_position = global_position + Vector3(rng.randf_range(-0.1, 0.1), rng.randf_range(-0.1, 0.1), rng.randf_range(-0.1, 0.1))
		bub.set_meta("type", type)
    bub.set_meta("value", scl.x * 100
	else:
		#print("not spawned, too far away from player")
		pass

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_node("/root/Node3D/PlayerRig/Player")
	

func scale_between(x, minAllowed, maxAllowed, min, max):
	return (maxAllowed - minAllowed) * (x - min) / (max - min) + minAllowed

var depleted = 0

func deplete_content(amount: float):
	depleted += amount
	content -= amount
	var perc = scale_between(content / orig_content, .2, 1.0, 0, 1)
	scale = Vector3.ONE * perc
	if content <= 0:
		queue_free()
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	orig_content = content


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	spawn_timer += delta * rng.randf_range(.5, 1)
	if spawn_timer > spawn_rate:
		spawnBubble()
		spawn_timer = 0
