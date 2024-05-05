extends CharacterBody2D

var speed : int = 200
var sprint_speed = speed * 2
var is_sprinting : bool = false 
var animation_walk : float = 1.5
var animation_sprint = 4
var is_human : bool = true

	

@onready var ai_controller_2d: Node2D = $AIController2D2


func _on_area_key_1_body_entered(_body):
	print("Hello")
	position = Vector2(1024.0, 576.0)
	ai_controller_2d.reward += 1.0

func _on_area_door_1_body_entered(_body):
	position = Vector2(1024.0, 576.0)
	if "door_1" in Global.is_open_door:
		ai_controller_2d.reward += 1.0
	else:
		ai_controller_2d.reward -= 1.0

func _on_area_2d_body_entered(body):
	position = Vector2(1024.0, 576.0)
	ai_controller_2d.reward -= 1.0
	ai_controller_2d.reset()


func _physics_process(delta):
	var mouvment := Vector2()
	if is_human:
		if Input.is_action_pressed("right") and Input.is_action_pressed("down"):
			$AnimatedSprite2D.play("down-right")
			mouvment.x += 1
			mouvment.y += 1
		elif Input.is_action_pressed("left") and Input.is_action_pressed("down"):
			$AnimatedSprite2D.play("down-left")
			mouvment.x -= 1
			mouvment.y += 1
		elif Input.is_action_pressed("right") and Input.is_action_pressed("up"):
			$AnimatedSprite2D.play("up-right")
			mouvment.x += 1
			mouvment.y -= 1
		elif Input.is_action_pressed("left") and Input.is_action_pressed("up"):
			$AnimatedSprite2D.play("up-left")
			mouvment.x -= 1
			mouvment.y -= 1
		elif Input.is_action_pressed("right"):
			$AnimatedSprite2D.play("right")
			mouvment.x += 1
		elif Input.is_action_pressed("left"):
			$AnimatedSprite2D.play("left")
			mouvment.x -= 1
		elif Input.is_action_pressed("down"):
			$AnimatedSprite2D.play("down")
			mouvment.y += 1
		elif Input.is_action_pressed("up"):
			$AnimatedSprite2D.play("up")
			mouvment.y -= 1
		else:
			$AnimatedSprite2D.play("idle")

		
		if Input.is_action_pressed("sprint"):
			is_sprinting = true
			$AnimatedSprite2D.set_speed_scale(animation_sprint) 
		else:
			is_sprinting = false
			$AnimatedSprite2D.set_speed_scale(animation_walk) 
		
	else:
		mouvment.x = ai_controller_2d.move.x
		mouvment.y = ai_controller_2d.move.y
		
	if mouvment.length() > 0:
		mouvment = mouvment.normalized() * speed
		if is_sprinting:
			mouvment *= 2 # velocitat * 2
			
	move_and_collide(mouvment * delta)
	#move_and_slide()	
	

