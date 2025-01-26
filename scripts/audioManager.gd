extends Node

var music: AudioStreamPlayer
var music_stream: AudioStream
var plop: AudioStreamPlayer
var plop_stream: AudioStream


func _ready():
	# Load your music or sound
	music_stream = preload("res://our_assets/bgMusic.mp3")
	# Create an AudioStreamPlayer node and set the stream
	music = AudioStreamPlayer.new()
	plop  = AudioStreamPlayer.new()
	music.bus = "music"
	plop.bus = "fx"
	add_child(music)  # Add it to the scene tree
	add_child(plop)
	music.stream = music_stream
	music.play()  # Start playing the sound
	


func stop_music():
	if music.playing:
		music.stop()

func play_music():
	if !music.playing:
		music.play()
		
func play_plop(n : int):	
	plop_stream = load("res://our_assets/plop" + str(n) + ".wav")
	plop.stream = plop_stream
	plop.play()
	
