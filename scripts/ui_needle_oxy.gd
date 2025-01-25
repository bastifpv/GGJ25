extends Node2D
var oxy = 1000
var pop = 2
var relative_oxy


# Called when the node enters the scene tree for the first time.
func _ready() -> void:	
	$Oxy/needle_oxy.rotation_degrees = 0
	$home/Arrow_home.rotation_degrees = 30
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# berechnet wie viele Minuten das Oxy noch ausreicht
	# 1 min ist die Grenze zum roten bereich
	relative_oxy = oxy / (pop * 5)
	if relative_oxy > 1:
		relative_oxy = 1
	var degree = -90 + 180 * relative_oxy	
	$Oxy/needle_oxy.rotation_degrees = degree
	$Oxy/lbl_oxy.text = str(int(relative_oxy)*100) + "%" 
	
	# Dome Posi
	#print ("X: ")
	#print($"../../Player".global_position.x)
	#print ("Y: ")
	#print($"../../Player".global_position.y)
	var rel_y = $"../../Player".global_position.y - $"../../../dome".global_position.y
	var rel_x = $"../../Player".global_position.x - $"../../../dome".global_position.x
	var angle_to_dome = 180 - (tan(rel_y / rel_x)*180/3.1415926)
	
	$home/Arrow_home.rotation_degrees = angle_to_dome

func receive_oxygen_base_change(val: Variant) -> void:
	oxy = val


func receive_population_change(val: Variant) -> void:
	pop = val
	$population/lbl_population.text = str(val)


func _on_margin_container_oxygen_base_change(val: Variant) -> void:
	oxy = val


func _on_margin_container_population_change(val: Variant) -> void:
	pop = val
	$population/lbl_population.text = str(val)
