extends RemoteTransform2D

func _process(_delta):
	if Input.is_action_pressed("ui_right"):
		position = Vector2(40, -20)
	elif Input.is_action_pressed("ui_left"):
		position = Vector2(-40, -20)
