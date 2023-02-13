extends RemoteTransform2D

func _process(_delta):

# Makes the camera more dynamic. Moves with player
	if Input.is_action_pressed("crouch"):
		position = Vector2(0, 5)
		if Input.is_action_pressed("ui_right"):
			position = Vector2(40, 5)
		elif Input.is_action_pressed("ui_left"):
			position = Vector2(-40, 5)	
	else:
		if Input.is_action_pressed("ui_right"):
			position = Vector2(40, -20)
		elif Input.is_action_pressed("ui_left"):
			position = Vector2(-40, -20)
		else:
			position = Vector2(0, -20)
