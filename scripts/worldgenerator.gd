extends Node

var sand = preload("res://scenes/prefabs/sand.tscn")
const RENDER_DISTANCE = 50
var MaxRenderd = 0
var MinRenderd = 0
var player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_node("../PlayerRig/Player")
	print("X: " + str(player.position.x))
	print("Y: " + str(player.position.y))
	print("Z: " + str(player.position.z))
	generate_sand_initial()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	player = get_node("../PlayerRig/Player")
	on_move_generate_sand(player.position)
	pass

func generate_sand_initial():
	const SAND_LENGHT = 10
	var min_x = 0 - RENDER_DISTANCE
	var max_x = 0 + RENDER_DISTANCE
	var i = (max_x - min_x) / SAND_LENGHT
	var current_place = min_x
	while current_place < max_x:
		var sand_inst : RigidBody3D =  sand.instantiate()
		if (current_place < MinRenderd or current_place  > MaxRenderd):
			add_child(sand_inst)
			sand_inst.position =  Vector3(current_place, 0, 0)
			print("Added Sand on X:" + str(current_place))
		current_place = current_place + SAND_LENGHT
	MaxRenderd = max_x
	MinRenderd = min_x


func on_move_generate_sand(player_position):
	if (player_position.x + RENDER_DISTANCE > MaxRenderd):
		var sand_inst : RigidBody3D =  sand.instantiate()
		add_child(sand_inst)
		sand_inst.position =  Vector3(MaxRenderd+10, 0, 0)
		MaxRenderd = MaxRenderd+10
		
	if (player_position.x - RENDER_DISTANCE < MinRenderd):
		var sand_inst : RigidBody3D =  sand.instantiate()
		add_child(sand_inst)
		sand_inst.position =  Vector3(MinRenderd-10, 0, 0)
		MinRenderd=MinRenderd-10
