extends CharacterBody2D


const SPEED = 300.0

@onready var sprite = $AnimatedSprite2D

func _physics_process(delta):
	var direction = Input.get_axis("left", "right")
	var direction2 = Input.get_axis("up", "down")
	if direction:
		if !direction2:
			velocity.x = direction * SPEED
		else:
			velocity.x = direction * SPEED/2
		sprite.play('walk')
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if direction2:
		if !direction:
			velocity.y = direction2 * SPEED
		else:
			velocity.y = direction2 * SPEED/2
		sprite.play('walk')
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
	if !direction && !direction2:
		sprite.play('default')
	if direction > 0:
		sprite.flip_h = true
	elif direction < 0:
		sprite.flip_h = false
	move_and_slide()
