extends CharacterBody2D
class_name player

var speed := 120
var direccion := 0.0
var jump:= 280
const gravity := 9
@onready var anim := $AnimationPlayer
@onready var sprite := $Sprite2D
@onready var monedaLabel := $playerGUI/HBoxContainer/monedaLabel



func _ready():
	Global.player =self
	add_to_group("player")

func  _physics_process(delta):
	direccion = Input.get_axis("ui_left","ui_right")
	velocity.x = direccion * speed
	
	if direccion != 0:
		anim.play("walk")
	else:
		anim.play("idle")
	
	sprite.flip_h = direccion < 0 if direccion != 0 else sprite.flip_h
	
	if is_on_floor() and Input.is_action_just_pressed("ui_accept"):
		velocity.y -= jump
		
	if !is_on_floor():
		velocity.y += gravity
	
	move_and_slide()
	

func actualizaInterfazMoneda():
	monedaLabel.text = str(Global.moneda)
	


func _on_reset_area_body_entered(body: Node2D) -> void:
	get_tree().reload_current_scene()
	



func _on_caliz_body_entered(body: Node2D) -> void:
	get_tree().change_scene_to_file("res://world.tscn")
	pass # Replace with function body.
