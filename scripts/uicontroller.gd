extends Node

@onready var oxygenTank = $MarginContainer/VBoxContainer/OxygenTank/OxygenTankVal
@onready var oxygenBase = $MarginContainer/VBoxContainer/OxygenBase/OxygenBaseVal
@onready var population = $MarginContainer/VBoxContainer/Population/PopulationVal
@onready var gamePause = $Pause
@onready var pauseBtn = $PauseBtn

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	###init set
	setPopulation(10)
	setOxygenBase(20)
	setOxygenTank(30)
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

func setPopulation(val):
	population.set_text(str(val))
	
func setOxygenBase(val):
	oxygenBase.set_text(str(val))
	
func setOxygenTank(val):
	oxygenTank.set_text(str(val))


func recieveOxygenBase(val: Variant) -> void:
	setOxygenBase(val)

func recieveOxygenTank(val: Variant) -> void:
	setOxygenTank(val)

func recievePopulation(val: Variant) -> void:
	setPopulation(val)

	
func _on_pause_btn_pressed() -> void:
	print("pause")
	gamePause.visible = true
	pauseBtn.visible = false

func _on_pause_end_pause() -> void:
	print("endPause")
	gamePause.visible = false
	pauseBtn.visible = true
