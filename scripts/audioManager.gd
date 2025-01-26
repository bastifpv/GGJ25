extends Node

var music: AudioStreamPlayer
var music_stream: AudioStream = preload("res://our_assets/bgMusic.mp3")
var plop: AudioStreamPlayer
var plop_streams = []

const num_plops = 5

func _ready():
	# Create an AudioStreamPlayer node and set the stream
	music = AudioStreamPlayer.new()
	plop  = AudioStreamPlayer.new()
	music.bus = "music"
	plop.bus = "fx"
	add_child(music)  # Add it to the scene tree
	add_child(plop)
	music.stream = music_stream
	music.play()  # Start playing the sound
	for i in range(1, num_plops + 1):
		plop_streams.append(load("res://our_assets/plop" + str(i) + ".wav"))
	


func stop_music():
	if music.playing:
		music.stop()

func play_music():
	if !music.playing:
		music.play()
		
func play_plop(scale):	
	plop.stream = plop_streams[randi_range(0,4)]
	plop.pitch_scale = 2.0 - scale.x
	plop.play()
	
