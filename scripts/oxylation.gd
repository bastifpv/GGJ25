extends Node

# Signal to Emit the new Oxygen/Population state
signal oxygenBaseChange(val)
signal oxygenTankChange(val)
signal populationChange(val)


var UIController
var startTick

var population = 65.0
var baseOxygen = 700
var tankOxygen = 20

var deadpeople = 0

var time = 0
var populationIncreaseFactor = 1.00793
var oxygenConsumtionFactor = 0.0015

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Starting Oxygen Script")
	#startTick = Engine.get_physics_frames()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time += delta
	population = (65 * pow(populationIncreaseFactor, time)) - deadpeople
	populationChange.emit(roundf(population))
	
	baseOxygen -= population * oxygenConsumtionFactor
	oxygenBaseChange.emit(roundf(baseOxygen))
	
	tankOxygen -= oxygenConsumtionFactor
	oxygenTankChange.emit(roundf(tankOxygen))
	
	if baseOxygen == 0:
		print("!!! GAME OVER !!!")
	
	pass

# People die (abs num)
func anotherOneBitesTheDust(val):
	deadpeople += val

# Collect oxygen
func oxyForMe(val):
	tankOxygen += val
	oxygenTankChange.emit(roundf(tankOxygen))
	
# Deliver oxygen
func deliver():
	baseOxygen += tankOxygen
	tankOxygen = 0
	oxygenTankChange.emit(roundf(baseOxygen))
