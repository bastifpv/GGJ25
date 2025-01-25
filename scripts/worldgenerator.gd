extends Node

var sand = preload("res://scenes/prefabs/sand.tscn")
var chunk1 = preload("res://scenes/prefabs/chunks/chunk1.tscn")
const RENDER_DISTANCE = 50
var MaxRenderd = 0
var MinRenderd = 0
var MaxPlacedChunks = 0
var MinPlacedChunks = 0
var player : Node3D
const CHUNK_SIZE = 50


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_node("../PlayerRig/Player")
	print("X: " + str(player.position.x))
	print("Y: " + str(player.position.y))
	print("Z: " + str(player.position.z))
	generate_sand_initial()
	generate_initial_world()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	player = get_node("../PlayerRig/Player")
	on_move_generate_sand(player.position)
	on_move_place_chunk(player.position)

func generate_sand_initial():
	const SAND_LENGHT = 10
	var min_x = 0 - RENDER_DISTANCE
	var max_x = 0 + RENDER_DISTANCE
	var i = (max_x - min_x) / SAND_LENGHT
	var current_place = min_x
	while current_place <= max_x:
		var sand_inst : StaticBody3D =  sand.instantiate()
		if (current_place <= MinRenderd or current_place  > MaxRenderd):
			add_child(sand_inst)
			sand_inst.position =  Vector3(current_place, 0, 0)
			#print("Added Sand on X:" + str(current_place))
		current_place = current_place + SAND_LENGHT
	MaxRenderd = max_x
	MinRenderd = min_x


func on_move_generate_sand(player_position):
	if (player_position.x + RENDER_DISTANCE > MaxRenderd):
		var sand_inst : StaticBody3D =  sand.instantiate()
		add_child(sand_inst)
		sand_inst.position =  Vector3(MaxRenderd+10, 0, 0)
		MaxRenderd = MaxRenderd+10
		
	if (player_position.x - RENDER_DISTANCE < MinRenderd):
		var sand_inst : StaticBody3D =  sand.instantiate()
		add_child(sand_inst)
		sand_inst.position =  Vector3(MinRenderd-10, 0, 0)
		MinRenderd=MinRenderd-10

func generate_initial_world():
	#Generate left Chunk 
	var chunk_right1 : Node3D = get_random_chunk().instantiate()
	add_child(chunk_right1)
	chunk_right1.position = Vector3(0,0,0)
	#Generate right Chunk
	var chunk_left1 : Node3D = get_random_chunk().instantiate()
	add_child(chunk_left1)
	chunk_left1.position = Vector3(0-CHUNK_SIZE,0,0)
	MaxPlacedChunks = 1
	MinPlacedChunks = 1

func on_move_place_chunk(player_position):
	#print(str((player_position.x + RENDER_DISTANCE)/CHUNK_SIZE))
	if (((player_position.x + RENDER_DISTANCE)/CHUNK_SIZE)>MaxPlacedChunks):
		var chunk_right : Node3D = get_random_chunk().instantiate()
		add_child(chunk_right)
		chunk_right.position = Vector3(0+(CHUNK_SIZE*MaxPlacedChunks),0,0)
		MaxPlacedChunks = MaxPlacedChunks + 1
		#print("place new chunk right")
		
	if (((player_position.x - RENDER_DISTANCE)/CHUNK_SIZE)<MinPlacedChunks):
		var chunk_left : Node3D = get_random_chunk().instantiate()
		add_child(chunk_left)
		chunk_left.position = Vector3(0-(CHUNK_SIZE*abs(MinPlacedChunks)),0,0)
		MinPlacedChunks = MinPlacedChunks - 1
		#print("place new chunk left")
		
func get_random_chunk():
	var chunks = [chunk1]
	var random_index = randf_range(0, chunks.size()-1)
	return chunks[random_index]
