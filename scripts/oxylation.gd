extends Node

# Signal to Emit the new Oxygen/Population state
signal baseStorageChange(type, val)
signal tankChange(type, val)
signal populationChange(val)
signal xp_change(val)
signal level_up

var UIController
var startTick

var population = 65.0
var baseStorage = {
	"o2": 700,
	"h2": 0,
	"n2": 0
}
var tank = {
	"o2": 20,
	"h2": 0,
	"n2": 0
}
var player_level = 1
var xp = 0

var deadpeople = 0

var time = 0
var populationIncreaseFactor = 1.00793
var oxygenConsumtionFactor = 0.0015

const types = ["o2", "h2", "n2"]
const xp_map = {
	1: 5000,
	2: 500000
}
const needs_level = {
	"o2": 1,
	"h2": 2,
	"n2": 3
}

func may_collect(type: String) -> bool:
	return player_level >= needs_level[type]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time += delta
	population = (65 * pow(populationIncreaseFactor, time)) - deadpeople
	populationChange.emit(roundf(population))
	
	baseStorage["o2"] -= population * oxygenConsumtionFactor
	baseStorageChange.emit("o2", roundf(baseStorage["o2"]))
	
	if baseStorage["o2"] <= 0:
		print("!!! GAME OVER !!!")

func add_xp(val):
	xp += val
	if xp > xp_map[player_level]:
		xp -= xp_map[player_level]
		player_level += 1
		level_up.emit(player_level)
	xp_change.emit({"xp": roundf(xp), "lvl": roundf(player_level)})

# People die (abs num)
func anotherOneBitesTheDust(val):
	deadpeople += val

# Collect gases
func oneForMe(type, val):
	tank[type] += val
	tankChange.emit(type, roundf(tank[type]))
	
# Deliver gases
func deliver():
	for i in types:
		baseStorage[i] += tank[i]
		add_xp(tank[i])
		tank[i] = 0
		tankChange.emit(i, roundf(baseStorage[i]))
