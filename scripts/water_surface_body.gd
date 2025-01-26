extends StaticBody3D



func _on_body_entered(body: Node) -> void:
	if body.is_in_group("bubble"):
		body.queue_free()
