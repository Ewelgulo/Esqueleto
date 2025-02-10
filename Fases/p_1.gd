extends CharacterBody2D

var is_jumping:= false

const SPEED = 500.0
const JUMP_VELOCITY = -400.0

@onready var animacao := $anima as AnimatedSprite2D


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	#------------------------Pulo----------------------------------
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
		is_jumping = true 
	elif is_on_floor():
		is_jumping = false
	#-----------------------movimento---------------------------------------	
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		if is_jumping: false
		animacao.play("Andando")
		animacao.scale.x = direction
	elif is_jumping:
		animacao.play("Pulo")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		animacao.play("Parado")
	move_and_slide()
