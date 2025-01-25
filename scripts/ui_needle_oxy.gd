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

	
	# Dome Posi
	#print ("X: ")
	#print($"../../Player".global_position.x)
	#print ("Y: ")
	#print($"../../Player".global_position.y)
	var rel_y = player.global_position.y - dome.global_position.y
	var rel_x = player.global_position.x - dome.global_position.x
	var angle_to_dome = 180 - (tan(rel_y / rel_x)*180/3.1415926)

	$home/Arrow_home.rotation_degrees = angle_to_dome





func get_oxy(val: Variant) -> void:
	oxy = val


func get_population(val: Variant) -> void:
	pop = val
	$population/lbl_population.text = str(val)
