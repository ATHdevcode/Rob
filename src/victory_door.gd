extends Area2D


@export var level:int = 1

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		level += 1;
		get_tree().change_scene_to_file("res://levels/level_"+str(level)+".tscn")
		
