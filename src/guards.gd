extends CharacterBody2D

var length;
var dir = 1;
var pos;
@export var dis = 50

@export var speed = 30


const REACTION = preload("res://assets/reaction.png")
const REACTION_2 = preload("res://assets/reaction2.png")

func _ready() -> void:
	pos = position.x;
	length = position.x +dis;

func _physics_process(delta: float) -> void:
	
	if not is_on_floor():
		velocity += get_gravity() * delta;
	
	if floor(position.x) != floor(length):
		
		position.x += dir * speed * delta;
	else:
		#scale.x *= -1;
		$point.scale.x *= -1;
		
		dir *= -1;
		length = pos + dis * dir;
		
	if $point/RayCast2D.is_colliding():
		if $point/RayCast2D.get_collider().name == "Player" and not $point/RayCast2D.get_collider().is_hiddenin:
			
			$Reaction.texture = REACTION;
			$Reaction.show();
			print("I SAW something there, must have been the wind!")
		elif $point/RayCast2D.get_collider().name == "Player" and $point/RayCast2D.get_collider().is_hiddenin:
			$Reaction.texture = REACTION_2
			$Reaction.show()
	else:
		$Reaction.hide();
		
		
	move_and_slide();
