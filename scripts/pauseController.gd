extends Control

signal end_pause
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_restart_pressed() -> void:
	print("Restart")
	get_tree().reload_current_scene()
	
func _on_back_pressed() -> void:
	print("Back")
	end_pause.emit()
	
func _on_quit_pressed() -> void:
	print("Quit")
	get_tree().quit()
