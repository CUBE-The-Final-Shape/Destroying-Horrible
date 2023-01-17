extends RigidBody2D

func _on_Bullet_body_entered(body):
	if !body.is_in_group("player"):
		queue_free()
