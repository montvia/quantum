extends CharacterBody2D

@export var speed : int = 200 
var sprint_speed = speed * 2 
var is_sprinting : bool = false 
var animation_walk : float = 1.5 
var animation_sprint = 4 
var last_move : String = "" 
var is_atacking : bool = false 
var last_atack = Vector2()
@export var is_human : bool = true #per activar la IA


@onready var ai_controller_2d: Node2D = $AIController2D2

#recompenses IA

func _on_area_key_1_body_entered(_body):
	position = Vector2(1024.0, 576.0)
	ai_controller_2d.reward += 1.0

func _on_area_door_1_body_entered(_body):
	position = Vector2(1024.0, 576.0)
	if "door_1" in Global.is_open_door:
		ai_controller_2d.reward += 1.0
	else:
		ai_controller_2d.reward -= 1.0

func _on_area_2d_body_entered(_body):
	position = Vector2(1024.0, 576.0)
	ai_controller_2d.reward -= 1.0
	ai_controller_2d.reset()


func _on_animated_sprite_2d_animation_finished(): 
	if $AnimatedSprite2D.animation == "atk_" + last_move: 
		is_atacking = false
		remove_child($area_jugador) 
 

func _physics_process(delta):
	var movement := Vector2() #moviment 2d
	if is_human: 
		if not is_atacking: 
			#es defineix en quina direcció es el moviment
			if Input.is_action_pressed("right") and Input.is_action_pressed("down"):
				movement.x += 1
				movement.y += 1
				$AnimatedSprite2D.play("down_right")
				last_move = "down_right"
			elif Input.is_action_pressed("left") and Input.is_action_pressed("down"):
				movement.x -= 1
				movement.y += 1
				$AnimatedSprite2D.play("down_left")
				last_move = "down_left"
			elif Input.is_action_pressed("right") and Input.is_action_pressed("up"):
				movement.x += 1
				movement.y -= 1
				$AnimatedSprite2D.play("up_right")
				last_move = "up_right"
			elif Input.is_action_pressed("left") and Input.is_action_pressed("up"):
				movement.x -= 1
				movement.y -= 1
				$AnimatedSprite2D.play("up_left")
				last_move = "up_left"
			elif Input.is_action_pressed("right"):
				movement.x += 1
				$AnimatedSprite2D.play("right")
				last_move = "right"
			elif Input.is_action_pressed("left"):
				movement.x -= 1
				$AnimatedSprite2D.play("left")
				last_move = "left"
			elif Input.is_action_pressed("down"):
				movement.y += 1
				$AnimatedSprite2D.play("down")
				last_move = "down"
			elif Input.is_action_pressed("up"):
				movement.y -= 1
				$AnimatedSprite2D.play("up")
				last_move = "up"
			else: 
				$AnimatedSprite2D.play("idle_" + last_move) #quan no es pren cap boto s'activa l'animació d'aturada
		#activació de la animació d'atac 
		if Input.is_action_just_pressed("atack"):
			is_atacking = true
			$AnimatedSprite2D.play("atk_" + last_move)
			last_atack = "atk_" + last_move
		
#		if is_atacking == true:
#			atack_area.position = last_atack * 7
			
			#animacions de corre
			if $AnimatedSprite2D.animation == last_move:
				if Input.is_action_pressed("sprint"):
					is_sprinting = true
					$AnimatedSprite2D.set_speed_scale(animation_sprint)
				else:
					is_sprinting = false
					$AnimatedSprite2D.set_speed_scale(animation_walk)
	# si is_human=f la IA controla el personatge
	else:
		movement.x = ai_controller_2d.move.x
		movement.y = ai_controller_2d.move.y
	#normalitzar els vectors
	if movement.length() > 0:
		movement = movement.normalized() * speed
		if is_sprinting:
			movement *= 2 # velocitat * 2
	
	
	
		
	move_and_collide(movement * delta)
	#move_and_slide()
	
	
	

