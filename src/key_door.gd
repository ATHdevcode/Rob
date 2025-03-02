extends StaticBody2D




func _on_pin_body_entered(body: Node2D) -> void:
	if body.name == "Player" and body.has_key:
		queue_free()
		
