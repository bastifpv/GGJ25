extends RigidBody3D

@export var idle_anim: String = "idle"

var balloon_rigged = preload("res://scenes/balloon_rigged.tscn")
var xplosion = preload("res://scenes/prefabs/xplode.tscn")
var ap: AnimationPlayer
var force = 1500
var targetDirection = Vector3.ZERO
var balls: Array
var ctrl: MarginContainer
var bomb_action = false

const release_per_second = .5

func _ready():
	ap = $CollisionShape3D/diver/AnimationPlayer
	ap.playback_default_blend_time = 1.0
	#ap.autoplay = idle_anim
	balls.append(get_parent().get_node("Balloon"))
	balls.append(get_parent().get_node("Balloon_2"))
	balls.append(get_parent().get_node("Balloon_3"))
	ctrl = get_node("/root/Node3D/Control/MarginContainer")
	return

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	var add_vec = Vector3.ZERO
	targetDirection.z = 90
	var cur_anim = ap.current_animation
	var new_anim = idle_anim
	if Input.is_action_pressed("up"):
		targetDirection.z = 135
		add_vec.y += force
		new_anim = "swim"
	if Input.is_action_pressed("down"):
		targetDirection.z = 45
		add_vec.y -= force
		new_anim = "swim"
	if Input.is_action_pressed("right"):
		targetDirection.y = 0
		add_vec.x += force
		new_anim = "swim"
	if Input.is_action_pressed("left"):
		targetDirection.y = 180
		add_vec.x -= force
		new_anim = "swim"
	if Input.is_action_pressed("release"):
		var rel = release_per_second * delta
		for ball in balls:
			print(ball.size)
			if ball.size > 0.2:
				ball.size -= rel / 10
				ball.update_size()
				ctrl.oneForMe(ball.type, rel * -100)
	if Input.is_action_pressed("bomb"):
		if bomb_action == false:
			var bang: Node3D = xplosion.instantiate()
			get_parent().add_child(bang)
			bang.global_position = $CollisionShape3D/diver/Kopf.global_position
			bomb_action = true
	else:
		bomb_action = false
	
	apply_central_force(add_vec * delta)
	$CollisionShape3D.rotation_degrees = lerp($CollisionShape3D.rotation_degrees, targetDirection, delta * 2)
	if new_anim != cur_anim:
		ap.play(new_anim)

var acc = 0

func _on_body_entered(body: Node) -> void:
	# Deliver O2
	if body.is_in_group("dome"):
		ctrl.deliver()
		for ball in balls:
			ball.reset()

	# Collect Bubbles
	if body.is_in_group("bubble"):
		# Bist du schon groß? Prüfe ob man schon sammeln darf
		var type = body.get_meta("type")
		var source = body.get_parent()
		var amount = body.get_meta("value")
		if !ctrl.may_collect(type):
			return
		var add_scale = body.get_node("BubbleMesh").scale
		var ball
		for i in ctrl.types.size():
			if ctrl.types[i] == type:
				ball = balls[i]
		ball.size += amount / 1000
		body.pop()
		ball.update_size()
		ctrl.oneForMe(type, amount)
		source.deplete_content(amount)
		
	# Spikey, ouchie
	if body.is_in_group("spikey"):
		AudioManager.play_wilhelm()
		for ball in balls:
			ball.size = ball.default_size
			ball.update_size()
			ctrl.oneForMe(ball.type, -ctrl.tank[ball.type])

func _on_level_up(lvl: int) -> void:
	get_parent().get_node("Balloon_" + str(lvl)).enable()
	get_parent().get_node("Rope_" + str(lvl)).show()
