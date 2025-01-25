extends RigidBody3D

@export var idle_anim: String = "idle"
var ap: AnimationPlayer
var force = 1500
var targetDirection = Vector3.ZERO
var ball: RigidBody3D
var ctrl: MarginContainer

func _ready():
	ap = $diver/AnimationPlayer
	ap.playback_default_blend_time = 1.0
	#ap.autoplay = idle_anim
	ball = get_parent().get_node("Balloon")
	ctrl = get_node("/root/Node3D/Control/MarginContainer")
	return

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	var add_vec = Vector3.ZERO
	targetDirection.z = 0
	var cur_anim = ap.current_animation
	var new_anim = idle_anim
	if Input.is_action_pressed("up"):
		targetDirection.z = 45
		add_vec.y += force
		new_anim = "swim"
	if Input.is_action_pressed("down"):
		targetDirection.z = -45
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
	
	apply_central_force(add_vec * delta)
	$diver.rotation_degrees = lerp($diver.rotation_degrees, targetDirection, delta * 2)
	if new_anim != cur_anim:
		ap.play(new_anim)


func _on_body_entered(body: Node) -> void:
	# Deliver O2
	if body.is_in_group("dome"):
		ctrl.deliver()
		ball.reset()

	# Collect Bubbles
	if body.is_in_group("bubble"):
		var add_scale = body.get_node("BubbleMesh").scale
		ball.size += add_scale.x / 10
		body.queue_free()
		ball.update_size()
		ctrl.oxyForMe(add_scale.x * 100)

func _on_level_up() -> void:
	var new_ball = ball.instantiate()
	get_parent().add_child(new_ball)
	pass # Replace with function body.
