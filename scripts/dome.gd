extends Node3D

var people = 0;

var people_array = [
	preload("res://scenes/prefabs/people/girl-skirt.tscn"),
	preload("res://scenes/prefabs/people/man-casual.tscn"),
	preload("res://scenes/prefabs/people/woman-casual-pants.tscn")
]

func spawn_person():
	var src = people_array.pick_random()
	var person_inst: Node3D = src.instantiate()
	var new_pos = Vector3(randf_range(-1.0, 1.0), 0.0, randf_range(-1.0, 1.0)).normalized()
	new_pos *= 4.0 * randf()
	$People.add_child(person_inst)
	person_inst.position = new_pos

func population_change(val):
	var new_people = int(val / 10) + 1
	while new_people > people:
		people += 1
		spawn_person()
