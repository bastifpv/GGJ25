extends Node2D
var oxy = 1000
var pop = 2
var relative_oxy

@export var player: Node3D
@export var dome: Node3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:	
	$Oxy/needle_oxy.rotation_degrees = 0
	$home/Arrow_home.rotation_degrees = 30
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# berechnet wie viele Minuten das Oxy noch ausreicht
	# 1 min ist die Grenze zum roten bereich
	relative_oxy = oxy / (pop * 5.4)
	
	if relative_oxy > 1:
		relative_oxy = 1
	if relative_oxy < 0:
		relative_oxy = 0
	var degree = -90 + 180 * relative_oxy	
	$Oxy/needle_oxy.rotation_degrees = degree
	$Oxy/lbl_oxy.text = str(int(relative_oxy*100)) + "%" 
	$home/Arrow_home.global_rotation = player.global_position.angle_to(dome.global_position)



func get_oxy(type: String, val: int) -> void:
	if type == "o2":
		oxy = val


func get_population(val: Variant) -> void:
	pop = val
	$population/lbl_population.text = str(val)
