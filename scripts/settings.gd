extends Control

var fx_index: int
var volume_index: int
@onready var musicSlider = $MarginContainer/VBoxContainer/musicVolume
@onready var fxSlider = $MarginContainer/VBoxContainer/fxVolume


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	fx_index = AudioServer.get_bus_index("fx")
	volume_index = AudioServer.get_bus_index("music")
	
	fxSlider.value = db_to_linear(AudioServer.get_bus_volume_db(fx_index))
	musicSlider.value = db_to_linear(AudioServer.get_bus_volume_db(volume_index))
	
	pass # Replace with function body.


func _on_slider_update(value: bool) -> void:
	if value:
		AudioServer.set_bus_volume_db(fx_index, linear_to_db(fxSlider.value))
		AudioServer.set_bus_volume_db(volume_index, linear_to_db(musicSlider.value))


func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
