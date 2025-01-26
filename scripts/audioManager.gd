extends Node

var music: AudioStreamPlayer
var music_stream: AudioStream = preload("res://our_assets/bgMusic.mp3")
var plop: AudioStreamPlayer
var plop_streams = []
var sfx: AudioStreamPlayer
var wilhelm: AudioStream = preload("res://our_assets/Wilhelmscream.wav")
var xplode: AudioStream = preload("res://our_assets/xplode.wav")

const num_plops = 5

func _ready():
	# Create an AudioStreamPlayer node and set the stream
	music = AudioStreamPlayer.new()
	plop  = AudioStreamPlayer.new()
	sfx  = AudioStreamPlayer.new()
	music.bus = "music"
	plop.bus = "fx"
	add_child(music)  # Add it to the scene tree
	add_child(plop)
	add_child(sfx)
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
	
func play_wilhelm():
	if !sfx.playing:
		sfx.stream = wilhelm
		sfx.play()
	
func play_boom():
	if !sfx.playing:
		sfx.stream = xplode
		sfx.play()
