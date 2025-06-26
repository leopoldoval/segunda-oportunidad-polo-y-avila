extends CharacterBody2D

const ghostrun = 80
const gravedad = 90

func _ready() -> void:
	velocity.x = ghostrun
	$AnimatedSprite2D.play("run")
	
func _physics_process(delta):
	velocity.y += gravedad
	
	if is_on_wall():
		if !$AnimatedSprite2D.flip_h:
			velocity.x = ghostrun
		else:
			velocity.x = -ghostrun
			
	if velocity.x < 0:
		$AnimatedSprite2D.flip_h = false
	elif  velocity.x > 0:
		$AnimatedSprite2D.flip_h = true
		
	 
	
	move_and_slide()
