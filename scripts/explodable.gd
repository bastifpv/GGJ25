extends StaticBody3D

var soft_mat = preload("res://materials/sandstone.tres")
var destroying = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$"stone-snow".material_override = soft_mat
	set_meta("explodable", true)
	set_collision_layer_value(5, true)

func destroy():
	destroying = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if destroying:
		$"stone-snow".transparency = lerp($"stone-snow".transparency, 1.0, delta)
		if $"stone-snow".transparency == 0.0:
			destroy()
