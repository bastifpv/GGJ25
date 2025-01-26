extends Node

@onready var text = $Panel/VBoxContainer/text
signal update_score

var game_over_messages = [
	"Only %d gasped their final breath as the last embers of your world faded to darkness.",
	"%d hearts beat their final rhythm, silenced by the weight of their crumbling world.",
	"%d souls were extinguished in the shadow of your shattered empire.",
	"%d lives clung desperately to hope before it vanished into the void.",
	"%d voices called out, only to be drowned in the suffocating silence of the end.",
	"%d dreams dissolved into ash as the cruel hand of fate closed in.",
	"%d lives unraveled as the last light of your civilisation flickered and died.",
	"%d hearts once burned bright, now consumed by the darkness you could not hold back.",
	"%d souls stood at the precipice, swallowed whole by the abyss of despair.",
	"%d cries echoed through the void, unanswered as your world suffocated.",
	"%d lives once thrived, now lost beneath the crushing weight of your failure.",
	"%d sparks of life were snuffed out, leaving only the cold shadow of regret.",
	"%d breaths faltered, fading as the walls of your civilisation caved in.",
	"%d hearts slowed, undone by the suffocating collapse of everything they knew.",
	"%d souls stood witness to the final gasp of your faltering empire.",
	"%d lives unraveled into nothingness as your grasp slipped from the reins of destiny.",
	"%d voices fell silent, swallowed by the merciless void of failure.",
	"%d stood at the edge of eternity, only to be cast into the shadows of defeat.",
	"%d lives ended where hope had long since fled, swallowed by the end you could not prevent.",
	"%d hearts faltered, choked beneath the weight of your civilisation's last moments.",
	"%d souls clung to the dying embers of life, only to be lost in the cold vacuum of oblivion."
]
var highscore_file = "user://highscore.json"
var highscore = 0


func _ready() -> void:
	text.text = game_over_messages[randi_range(0, 20)] % 500 #Global.population
	update_score.emit()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_restart_pressed() -> void:
	print("Main Menu")
	get_tree().change_scene_to_file("res://scenes/startscene.tscn")


func _on_main_menu_pressed() -> void:
	print("Main Menu")
	get_tree().change_scene_to_file("res://scenes/menu.tscn")


func _on_quit_pressed() -> void:
	print("Quit")
	get_tree().quit()
