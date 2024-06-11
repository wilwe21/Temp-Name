extends CharacterBody2D


const SPEED = 300.0

@onready var sprite = $AnimatedSprite2D

func _physics_process(delta):

	var direction = Input.get_axis("left", "right")
	var direction2 = Input.get_axis("up", "down")
	if direction:
		velocity.x = direction * SPEED
		if !direction2:
			sprite.play('walk')
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if !direction2:
			sprite.play('default')
	if direction2:
		velocity.y = direction2 * SPEED
		if !direction:
			sprite.play("fly")
	else:
		velocity.y = move_toward(velocity.x, 0, SPEED)
		if !direction:
			sprite.play('default')
	if direction && direction2:
		sprite.play('fly')
	if direction > 0:
		sprite.flip_h = true
	elif direction < 0:
		sprite.flip_h = false
	move_and_slide()
