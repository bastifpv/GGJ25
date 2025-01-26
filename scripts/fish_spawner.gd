extends Node3D

@export var type: String = ""
@export_range(0.0, 1.0) var spawn_rate: float = .95

var fishy = preload("res://scenes/fishy.tscn")
var spawn_timer: float = 0
var player : Node3D
var fish_counter = 0

const min_scale = .2

func _ready() -> void:
	player = get_node("/root/Node3D/PlayerRig/Player")
	for i in range (5):
		spawn_fish()

func spawn_fish():
	if fish_counter < 30:
		if (player.global_position - global_position).abs() < Vector3(10,10,0):
			return
		var fish: Node3D =  fishy.instantiate()	
		add_child(fish)			
		fish.global_position = Vector3(randf_range(-50, 50), randf_range(2, 10), randf_range(-10, 10))
		fish_counter += 1
	

func _process(delta: float) -> void:
	spawn_timer += delta * randf_range(2, 10)
	if spawn_timer > spawn_rate:
		spawn_fish()
		spawn_timer = 0
