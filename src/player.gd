extends CharacterBody2D


const SPEED = 250.0
const JUMP_VELOCITY = -550.0
var booster = 1;

var is_hiddenin = false
var is_hid = false
var hidable = false
var hidearea;

var has_key = false;

enum nintech {
	SMOKE, SPEED
}
var moves = [nintech.SMOKE, nintech.SPEED]

@onready var smokes = load("res://entity/smoke.tscn")



	
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("a"):
		usemove(moves[0])
	if Input.is_action_just_pressed("b"):
		usemove(moves[1])

func _physics_process(delta: float) -> void:
	# Add the gravity.
	#print(Engine.get_frames_per_second())
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	if not is_on_floor():
		pass
		#$AnimatedSprite2D.play("jump")
		
		if is_hiddenin:
			$AnimatedSprite2D.z_index = 0;
			is_hiddenin = false
			hidable = true

	
	var direction := Input.get_axis("ui_left", "ui_right")
	
	$AnimationTree.set("parameters/conditions/ideal", !direction)
	$AnimationTree.set("parameters/conditions/run", direction)
	
	
	if not is_hiddenin:
		if direction:
			$AnimatedSprite2D.scale.x = direction;
			
			
			velocity.x = direction * SPEED*booster
		else:
			if is_on_floor():
				pass
				
				
			velocity.x = move_toward(velocity.x, 0, SPEED)
			
			
			
	
			
	if hidable and Input.is_action_just_pressed("click"):
		playerhide(position, hidearea)
	elif is_hiddenin and Input.is_action_just_pressed("click"):
		$AnimatedSprite2D.z_index = 0;
		is_hiddenin = false
		hidable = true
		
		

	move_and_slide()
	

func playerhide(position, area):
	is_hiddenin = true
	hidable = false
	position.x = area.position.x;
	$AnimatedSprite2D.z_index -= 1


func _on_hitbox_body_entered(body: Node2D) -> void:
	print("hits body:"+body.name);



func _on_hitbox_area_entered(area: Area2D) -> void:
	print("hits area:"+area.name);
	
	if area.name == "key":
		has_key = true;
		area.queue_free()
	
	#guards
	if area.name == "point" and not is_hiddenin and not is_hid:
		print("GOT CAUGHT!!!!!$%%%")
		get_tree().reload_current_scene();
	#cctv
	if area.name == "RayCast2D" and not is_hiddenin and not is_hid:
		get_tree().reload_current_scene();
	
	if area.is_in_group("hide"):
		hidable = true
		hidearea = area
		
		
func _on_hitbox_area_exited(area: Area2D) -> void:
	if area.is_in_group("hide"):
		hidable = false
		is_hiddenin = false
		
func usemove(move):
	if move == nintech.SMOKE:
		$AnimationTree.set("parameters/conditions/smoke", true)
		
		var inst = smokes.instantiate()
		inst.position.x = position.x
		inst.position.y = position.y+20
		get_parent().add_child(inst)
	elif move == nintech.SPEED:
		booster = 2
		$speed.start()
		$AnimatedSprite2D/CPUParticles2D.emitting = true
		$AnimatedSprite2D/CPUParticles2D2.emitting = true
		$AnimatedSprite2D/CPUParticles2D3.emitting = true


func _on_speed_timeout() -> void:
	booster = 1
	$AnimatedSprite2D/CPUParticles2D.emitting = false
	$AnimatedSprite2D/CPUParticles2D2.emitting = false
	$AnimatedSprite2D/CPUParticles2D3.emitting = false


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "smoke":
		print("done")
		$AnimationTree.set("parameters/conditions/smoke", false)
	
func smokefin():
	$AnimationTree.set("parameters/conditions/smoke", false)
	
