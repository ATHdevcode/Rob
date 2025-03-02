extends Area2D


@export var text = "SAMPLE";

func _ready() -> void:
	$CanvasLayer/Label.text = text;
	$CanvasLayer.hide();
	



func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		$CanvasLayer.show();
		


func _on_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		$CanvasLayer.hide();
