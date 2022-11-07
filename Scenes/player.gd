extends KinematicBody2D

signal killed()
signal health_updated(health)

export var right = true

export (int) var speed = 100
export (int) var jump_strength = 200
export (int) var gravity = 1000
export (int) var max_health = 100
const UP_DIRECTION = Vector2.UP
onready var health = max_health setget _set_health

var velocity = Vector2()

func _physics_process(delta):
	
	var horizontal_direction = (
		Input.get_action_strength("right")
		- Input.get_action_strength("left")
	)
	
	velocity.x = horizontal_direction * speed
	velocity.y += gravity * delta
	
	var is_jumping := Input.is_action_just_pressed("up") and is_on_floor()
	
	var is_crouching := Input.is_action_pressed("crouch")
	
	if is_jumping:
		velocity.y = -jump_strength
		
	if is_crouching:
		speed = 50
		
	if is_crouching == false:
		speed = 100
			
	velocity = move_and_slide(velocity, UP_DIRECTION)
	
	if Input.is_action_pressed("k"):
		damage(10)
	
func damage(amount):
	_set_health(health - amount)
	
func kill():
	pass

func _set_health(value):
	var prev_health = health
	health = clamp(value, 0, max_health)
	if health != prev_health:
		emit_signal("health_updated", health)
		if health == 0:
			kill()
			emit_signal("killed")


#Waliking animations WORKS!!!
onready var _animated_sprite = $AnimatedSprite

func _process(_delta):
	if Input.is_action_pressed("crouch"):
		get_node("Collision_Standing").disabled= true
		if Input.is_action_pressed("ui_right"):
			_animated_sprite.play("crouch_right")
			right = true

		elif Input.is_action_pressed("ui_left"):
			_animated_sprite.play("crouch_left")
			right = false
		
		elif right == true:
			_animated_sprite.play("crouch_idle_right")	
		
		else:
			_animated_sprite.play("crouch_idle_left")	
	else:
		get_node("Collision_Standing").disabled= false
		if Input.is_action_pressed("ui_right"):
			_animated_sprite.play("walk_right")
			right = true

		elif Input.is_action_pressed("ui_left"):
			_animated_sprite.play("walk_left")
			right = false
		
		elif right == true:
			_animated_sprite.play("idle_right")	
		
		else:
			_animated_sprite.play("idle_left")	
