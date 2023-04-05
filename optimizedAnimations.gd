
# Animation code below. It is a mess
onready var _animated_sprite = $AnimatedSprite

func _process(_delta):
	# Checks for cursor position. The data is used to always keep the player facing the cursor
	var mpos = get_global_mouse_position()
	var pos = global_position
	var rot = rad2deg((mpos - pos).angle())
	# This is honestly a mess of animation code but it makes sure that the correct animation is played for every action. 
	# It checks for if the player is crouching or not and makes sure the player always faces their cursor
	# Rotates the sprite to always face the camera (Exept when idle...)
	if(rot >= -90 and rot <= 90):
		if Input.is_action_pressed("ui_right"):	
			$".".get_node("AnimatedSprite").flip_h = false
		elif Input.is_action_pressed("ui_left"):
			$".".get_node("AnimatedSprite").flip_h = true
	else:
		if Input.is_action_pressed("ui_right"):	
			$".".get_node("AnimatedSprite").flip_h = true
		elif Input.is_action_pressed("ui_left"):
			$".".get_node("AnimatedSprite").flip_h = false
	
	if Input.is_action_pressed("crouch"):
		get_node("Collision_Standing").disabled = true
	else:
		get_node("Collision_Standing").disabled = false
	
	if Input.is_action_pressed("null"):	
		_animated_sprite.play("idle_right")
		if Input.is_action_pressed("crouch"):
			_animated_sprite.play("idle_crouch_right")
			
	
	# Somewhat optimized animation script
	if Input.is_action_pressed("ui_right"):	
		if Input.is_action_pressed("crouch"):
			_animated_sprite.play("crouch_right")
		else:
			_animated_sprite.play("walk_right")
	elif Input.is_action_pressed("ui_left"):
		if Input.is_action_pressed("crouch"):
			_animated_sprite.play("crouch_left")
		else:
			_animated_sprite.play("walk_left")
			
			if(rot >= -90 and rot <= 90):
				_animated_sprite.play("idle_right")
			else:
				_animated_sprite.play("idle_left")
