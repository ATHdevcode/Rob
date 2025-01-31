extends StaticBody2D

@export var pincode = 8081

func _ready() -> void:
	$CanvasLayer.hide()
	

func _on_pin_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		$CanvasLayer.show();


func _on_pin_area_exited(area: Area2D) -> void:
	if area.is_in_group("player"):
		$CanvasLayer.hide();


func _on_ok_pressed() -> void:
	if $CanvasLayer.inputed_value == str(pincode):
		queue_free();
	else:
		$CanvasLayer.inputed_value = "";
