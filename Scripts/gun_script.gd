extends KinematicBody2D

export var bullet_speed = 250
export var fire_rate = 0.3
onready var _animated_sprite = $shootReaction

var bullet = preload("res://Scenes/Bullet.tscn")
var can_fire = true

var mouseposition

func _process(_delta):
	mouseposition = get_local_mouse_position()
	rotation+= mouseposition.angle() * 1

	if Input.is_action_pressed("fire") and can_fire and is_visible():
		
		var bullet_instance = bullet.instance()
		bullet_instance.position = $BulletPoint.get_global_position()
		bullet_instance.rotation_degrees = rotation_degrees
		bullet_instance.apply_impulse(Vector2(), Vector2(bullet_speed, 0).rotated(rotation))
		get_tree().get_root().add_child(bullet_instance)
		can_fire = false
		_animated_sprite.play("shoot")
		yield(get_tree().create_timer(fire_rate), "timeout")
		can_fire = true
		_animated_sprite.play("idle")
