extends Node

var sand = preload("res://scenes/prefabs/sand.tscn")
var chunks = [
	preload("res://scenes/prefabs/chunks/chunk1.tscn"),
	preload("res://scenes/prefabs/chunks/chunk2.tscn")
]
const RENDER_DISTANCE = 50
var MaxRenderd = 0
var MinRenderd = 0
var MaxPlacedChunks = 1
var MinPlacedChunks = 1
var player : Node3D
const CHUNK_SIZE = 50
const CHUNK_DISPLACEMENT = .5
const SAND_LENGHT = 10
const SAND_Y_DISPLACEMENT = -.25


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
	on_move_place_chunk(player.position)

func generate_sand_initial():
	var min_x = 0 - RENDER_DISTANCE
	var max_x = 0 + RENDER_DISTANCE
	var i = (max_x - min_x) / SAND_LENGHT
	var current_place = min_x
	while current_place <= max_x:
		var sand_inst : StaticBody3D =  sand.instantiate()
		if (current_place <= MinRenderd or current_place  > MaxRenderd):
			add_child(sand_inst)
			sand_inst.position =  Vector3(current_place, SAND_Y_DISPLACEMENT, 0)
			#print("Added Sand on X:" + str(current_place))
		current_place = current_place + SAND_LENGHT
	MaxRenderd = max_x
	MinRenderd = min_x


func on_move_generate_sand(player_position):
	if (player_position.x + RENDER_DISTANCE > MaxRenderd):
		var sand_inst : StaticBody3D =  sand.instantiate()
		add_child(sand_inst)
		sand_inst.position =  Vector3(MaxRenderd+10, SAND_Y_DISPLACEMENT, 0)
		MaxRenderd = MaxRenderd+10
		
	if (player_position.x - RENDER_DISTANCE < MinRenderd):
		var sand_inst : StaticBody3D =  sand.instantiate()
		add_child(sand_inst)
		sand_inst.position =  Vector3(MinRenderd-10, SAND_Y_DISPLACEMENT, 0)
		MinRenderd=MinRenderd-10

func on_move_place_chunk(player_position):
	#print(str((player_position.x + RENDER_DISTANCE)/CHUNK_SIZE))
	if (((player_position.x + RENDER_DISTANCE)/CHUNK_SIZE)>MaxPlacedChunks):
		var chunk_right : Node3D = get_random_chunk().instantiate()
		add_child(chunk_right)
		chunk_right.position = Vector3(0+(CHUNK_SIZE*MaxPlacedChunks),CHUNK_DISPLACEMENT,0)
		MaxPlacedChunks = MaxPlacedChunks + 1
		#print("place new chunk right")
		
	if (((player_position.x - RENDER_DISTANCE)/CHUNK_SIZE)<MinPlacedChunks):
		var chunk_left : Node3D = get_random_chunk().instantiate()
		add_child(chunk_left)
		chunk_left.position = Vector3(0-(CHUNK_SIZE*abs(MinPlacedChunks)),CHUNK_DISPLACEMENT,0)
		MinPlacedChunks = MinPlacedChunks - 1
		#print("place new chunk left")
		
func get_random_chunk():
	var random_index = randi_range(0, chunks.size()-1)
	return chunks[random_index]
