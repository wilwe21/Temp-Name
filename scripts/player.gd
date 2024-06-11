extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var stamina = 50

@onready var sprite = $AnimatedSprite2D

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
		sprite.play('fly')
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
		if is_on_floor():
			sprite.play('walk')
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if is_on_floor():
			sprite.play('default')
	if Input.is_action_just_pressed("up") and stamina != 0:
		velocity.y = JUMP_VELOCITY
		stamina -= 10
	if is_on_floor():
		stamina = 50
	if direction > 0:
		sprite.flip_h = true
	elif direction < 0:
		sprite.flip_h = false
	move_and_slide()
