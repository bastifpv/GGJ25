extends Node

# Signal to Emit the new Oxygen/Population state
signal oxygenBaseChange(val)
signal oxygenTankChange(val)
signal populationChange(val)


var UIController
var startTick

var population = 2.0
var baseOxygen = 100
var tankOxygen = 20

var populationIncreaseFactor = 0.05
var oxygenConsumtionFactor = 0.0015

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Starting Oxygen Script")
	#startTick = Engine.get_physics_frames()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	population += population * populationIncreaseFactor * delta
	populationChange.emit(roundf(population))
	
	baseOxygen -= population * oxygenConsumtionFactor
	oxygenBaseChange.emit(roundf(baseOxygen))
	
	tankOxygen -= oxygenConsumtionFactor
	oxygenTankChange.emit(roundf(tankOxygen))
	
	if baseOxygen == 0:
		print("!!! GAME OVER !!!")
	
	pass
