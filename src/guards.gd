extends CharacterBody2D

var length;
var dir = 1;
var pos;
var dis = 50

func _ready() -> void:
	pos = position.x;
	length = position.x +dis;

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta;
	
	if floor(position.x) != floor(length):
		
		position.x += dir * 30 * delta;
	else:
		scale.x *= -1;
		dir *= -1;
		length = pos + dis * dir;
		
		
	move_and_slide();
