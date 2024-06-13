extends CharacterBody2D


var SPEED = 400.0
var fly = false
var alive = true
var water = false

@onready var sprite = $AnimatedSprite2D
@onready var dead = $dead


func set_fly():
	if fly:
		fly = false
		SPEED = 400.0
		set_collision_layer_value(2, false)
		set_collision_mask_value(2, false)
		set_collision_layer_value(1, true)
		set_collision_mask_value(1, true)
	else:
		fly = true
		SPEED = 600.0
		set_collision_layer_value(2, true)
		set_collision_mask_value(2, true)
		set_collision_layer_value(1, false)
		set_collision_mask_value(1, false)

func _physics_process(delta):
	if alive:
		var direction = Input.get_axis("left", "right")
		var direction2 = Input.get_axis("up", "down")
		if Input.is_action_just_pressed("fly"):
			set_fly()
		if direction:
			if !direction2:
				velocity.x = direction * SPEED
			else:
				velocity.x = direction * SPEED/1.5
			if !fly:
				sprite.play('walk')
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
		if direction2:
			if !direction:
				velocity.y = direction2 * SPEED
			else:
				velocity.y = direction2 * SPEED/1.5
			if !fly:
				sprite.play('walk')
		else:
			velocity.y = move_toward(velocity.y, 0, SPEED)
		if fly:
			sprite.play('fly')
		elif !direction && !direction2:
			sprite.play('default')
		if direction > 0:
			sprite.flip_h = true
		elif direction < 0:
			sprite.flip_h = false
		if water && !fly:
			alive = false
		move_and_slide()
	else:
		sprite.hide()
		dead.show()
		if Input.is_action_just_pressed("restart"):
			get_tree().reload_current_scene()

func _on_area_2d_body_entered(body):
	water = true
	if !fly:
		alive = false


func _on_area_2d_body_exited(body):
	water = false
