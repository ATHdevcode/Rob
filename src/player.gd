extends CharacterBody2D


const SPEED = 250.0
const JUMP_VELOCITY = -550.0

var is_hiddenin = false
var hidable = false
var hidearea;

var has_key = false;



func _physics_process(delta: float) -> void:
	# Add the gravity.
	#print(Engine.get_frames_per_second())
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	if not is_on_floor():
		$AnimatedSprite2D.play("jump")
		
		if is_hiddenin:
			$ColorRect.z_index = 0;
			is_hiddenin = false
			hidable = true

	
	var direction := Input.get_axis("ui_left", "ui_right")
	
	if not is_hiddenin:
		if direction:
			$AnimatedSprite2D.scale.x = direction;
			$AnimatedSprite2D.play("run")
			velocity.x = direction * SPEED
		else:
			if is_on_floor():
				$AnimatedSprite2D.play("ideal")
			velocity.x = move_toward(velocity.x, 0, SPEED)
			
	
			
	if hidable and Input.is_action_just_pressed("click"):
		playerhide(position, hidearea)
	elif is_hiddenin and Input.is_action_just_pressed("click"):
		$ColorRect.z_index = 0;
		is_hiddenin = false
		hidable = true
		
		

	move_and_slide()
	

func playerhide(position, area):
	is_hiddenin = true
	hidable = false
	position.x = area.position.x;
	$ColorRect.z_index -= 1


func _on_hitbox_body_entered(body: Node2D) -> void:
	print("hits body:"+body.name);



func _on_hitbox_area_entered(area: Area2D) -> void:
	print("hits area:"+area.name);
	
	if area.name == "key":
		has_key = true;
		area.queue_free()
	
	#guards
	if area.name == "point" and not is_hiddenin:
		print("GOT CAUGHT!!!!!$%%%")
		get_tree().reload_current_scene();
	#cctv
	if area.name == "RayCast2D" and not is_hiddenin:
		get_tree().reload_current_scene();
	
	if area.is_in_group("hide"):
		hidable = true
		hidearea = area
		
		
func _on_hitbox_area_exited(area: Area2D) -> void:
	if area.is_in_group("hide"):
		hidable = false
		is_hiddenin = false
