extends Node2D






func _on_button_2_pressed() -> void:
	var tween = get_tree().create_tween();
	tween.tween_property($block, "position", Vector2(-500, 0), 0.5);


func _on_back_pressed() -> void:
	var tween = get_tree().create_tween();
	tween.tween_property($block, "position", Vector2(0, 0), 0.5);


func _on_play_pressed() -> void:
	var tween = get_tree().create_tween();
	tween.tween_property($block, "position", Vector2(500, 0), 0.5);


func _on_lv_1_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/level_1.tscn");
