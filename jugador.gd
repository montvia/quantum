extends CharacterBody2D

var speed : int = 200
var sprint_speed = speed * 2
var is_sprinting : bool = false 


func _physics_process(delta):
	var mouvment := Vector2()
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
	else:
		is_sprinting = false

	if mouvment.length() > 0:
		mouvment = mouvment.normalized() * speed
		if is_sprinting:
			mouvment *= 2 # velocitat * 2
			
	move_and_collide(mouvment * delta)	
	
func _ready():
	pass

