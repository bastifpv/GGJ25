extends Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func startGame():
	print("StartGame")
	get_tree().change_scene_to_file("res://scenes/startscene.tscn")
	pass

func showCredits():
	print("showCredits")
	get_tree().change_scene_to_file("res://scenes/credits.tscn")
	pass

func showSettings():
	print("showSettings")
	get_tree().change_scene_to_file("res://scenes/settings.tscn")
	pass

func quitGame():
	print("QuitGame")
	get_tree().quit()
	pass
