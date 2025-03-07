extends StaticBody2D




func _on_pin_body_entered(body: Node2D) -> void:
	if body.name == "Player" and body.has_key:
		$AnimationPlayer.play("key")
		
		
		


func _on_animated_sprite_2d_animation_finished() -> void:
	queue_free()


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	$AnimatedSprite2D.play("default")
