extends Area2D




func _ready() -> void:
	$GPUParticles2D.emitting = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_gpu_particles_2d_finished() -> void:
	$delay.start();


func _on_delay_timeout() -> void:
	
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		
		body.is_hid = true
	


func _on_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		body.is_hid = false
