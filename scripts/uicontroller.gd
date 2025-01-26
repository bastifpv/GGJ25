extends Node

@onready var oxygenTank = $MarginContainer/VBoxContainer/OxygenTank/OxygenTankVal
@onready var oxygenBase = $MarginContainer/VBoxContainer/OxygenBase/OxygenBaseVal
@onready var playerLevel = $MarginContainer/VBoxContainer/PlayerLevel/PlayerLevelVal
@onready var playerXP = $MarginContainer/VBoxContainer/PlayerXP/PlayerXPVal
@onready var gamePause = $Pause
@onready var pauseBtn = $PauseBtn
@onready var gameOver = $gameOver

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	###init set
	setOxygenBase(20)
	setOxygenTank(30)
	setPlayerLevel(1)
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

func setOxygenBase(val):
	oxygenBase.set_text(str(val))

func setOxygenTank(val):
	oxygenTank.set_text(str(val))

func setPlayerLevel(val):
	playerLevel.set_text(str(val))
	
func setPlayerXP(val):
	playerXP.set_text(str(val))
	

func recieveBaseStorage(type: String, val: int) -> void:
	setOxygenBase(val)

func recieveTank(type: String, val: int) -> void:
	if type == "o2":
		setOxygenTank(val)


func _on_margin_container_xp_change(val: Variant) -> void:
	setPlayerLevel(val["lvl"])
	setPlayerXP(val["xp"])

	
func _on_pause_btn_pressed() -> void:
	print("pause")
	get_tree().paused = true
	gamePause.visible = true
	pauseBtn.visible = false

func _on_game_over(population: Variant) -> void:
	Global.population = population
	print("Game Over")
	get_tree().change_scene_to_file("res://scenes/gameOver.tscn")

func _on_pause_end_pause() -> void:
	print("endPause")
	gamePause.visible = false
	pauseBtn.visible = true
	get_tree().paused = false


func _on_body_entered(body: Node) -> void:
	pass # Replace with function body.
