extends CollisionShape2D

func _process(_delta):
	if Input.is_action_pressed("crouch"):
		get_node("").disabled= true
	else:
		get_node("").disabled= false
