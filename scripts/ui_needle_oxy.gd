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

func rotate_object_towards(obj_to_rotate: Node3D, target: Node3D):
	var origin = obj_to_rotate.global_transform.origin
	var target_pos = target.global_transform.origin

	var direction = Vector2(target_pos.x - origin.x, origin.y - target_pos.y).normalized()
	var angle = direction.angle()

	# Rotation als Transform3D (nur Z-Rotation)
	$home/Arrow_home.rotation= angle
	

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
	#print ("Dome pos: ")
	#print (dome.global_position)
	#print ("Player pos: ")
	#print (player.global_position)
	#print("Angle")
	#print(player.global_position.angle_to(dome.global_position))
	var pV2 = Vector2(player.global_position.x,player.global_position.y)
	var dV2 = Vector2(dome.global_position.x,dome.global_position.y)
	var direction = player.global_position - dome.global_position
	#ar angle_in_degrees = get_angle_between_objects(player, dome)
	rotate_object_towards(player, dome)
	#$home/Arrow_home. rotation = (pV2 - dV2).angle


func get_oxy(type: String, val: int) -> void:
	if type == "o2":
		oxy = val


func get_population(val: Variant) -> void:
	pop = val
	$population/lbl_population.text = str(val)
