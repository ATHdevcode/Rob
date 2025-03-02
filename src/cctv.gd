extends CharacterBody2D




var target = 1.1;
var dir = 1;
@export var speed:float = 1.0;


func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	
	if floor($RayCast2D.rotation) != floor(target):
		$RayCast2D.rotation += dir * speed * delta;
	else:
		target *= -1;
		dir *= -1;
