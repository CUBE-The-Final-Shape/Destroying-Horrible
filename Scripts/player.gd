extends KinematicBody2D

signal killed()
signal health_updated(health)

export (int) var speed = 100
export (int) var jump_strength = 200
export (int) var gravity = 700
export (int) var max_health = 100
const UP_DIRECTION = Vector2.UP
onready var health = max_health setget _set_health
onready var _animated_sprite = $AnimatedSprite
onready var right = 1

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
		
	# sets the players speed to 50 from 100 to slow the player down while crouching
	if is_crouching:
		speed = 50
	
	# reverses the speed change for when the player stops crouching
	if is_crouching == false:
		speed = 100
			
	velocity = move_and_slide(velocity, UP_DIRECTION)
	
	# Tests the health system by damaging the player if they pres k on their keyboard
	if Input.is_action_pressed("k"):
		damage(10)
	
func damage(amount):
	_set_health(health - amount)
	
func kill():
	pass

# Health script. If health is 0 the player dies
func _set_health(value):
	var prev_health = health
	health = clamp(value, 0, max_health)
	if health != prev_health:
		emit_signal("health_updated", health)
		if health == 0:
			kill()
			emit_signal("killed")


# Animation code below. It is a mess

func _process(_delta):
	# Checks for cursor position. The data is used to always keep the player facing the cursor
	var mpos = get_global_mouse_position()
	var pos = global_position
	var rot = rad2deg((mpos - pos).angle())
	# Collision code. Disables and enables the standing collision based on crouching 
	if Input.is_action_pressed("crouch"):
		get_node("Collision_Standing").disabled = true
	else:
		get_node("Collision_Standing").disabled = false
	# This is honestly a mess of animation code but it makes sure that the correct animation is played for every action. 
	# It checks for if the player is crouching or not and makes sure the player always faces their cursor
	if (right == 1):
		if (rot >= -90 and rot <= 90):
			$".".get_node("AnimatedSprite").flip_h = false
		else:
			$".".get_node("AnimatedSprite").flip_h = true
	else:
		if (rot >= -90 and rot <= 90):
			$".".get_node("AnimatedSprite").flip_h = true
		else:
			$".".get_node("AnimatedSprite").flip_h = false
	# Somewhat optimized animation script
	if Input.is_action_pressed("ui_right"):	
		right = 1
		if Input.is_action_pressed("crouch"):
			_animated_sprite.play("crouch_right")
		else:
			_animated_sprite.play("walk_right")
	elif Input.is_action_pressed("ui_left"):
		right = 0
		if Input.is_action_pressed("crouch"):
			_animated_sprite.play("crouch_left")
		else:
			_animated_sprite.play("walk_left")
	else:
		if(right == 1):
			_animated_sprite.play("idle_right")
			if Input.is_action_pressed("crouch"):
				_animated_sprite.play("crouch_idle_right")
		else:
			_animated_sprite.play("idle_left")
			if Input.is_action_pressed("crouch"):
				_animated_sprite.play("crouch_idle_left")
