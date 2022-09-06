extends CollisionShape2D

export var bullet_speed = 100

var bullet = preload("res://Scenes/Bullet.tscn")

func _process(delta):
	look_at(get_global_mouse_position())

	if Input.is_action_pressed("fire"):
		var bullet_instance = bullet.instance()
		bullet_instance.position = get_global_position()
		bullet_instance.rotation_degrees = rotation_degrees
		bullet_instance.apply_impulse(Vector2(), Vector2(bullet_speed, 0).rotated(rotation))
		get_tree().get_root().add_child(bullet_instance)
