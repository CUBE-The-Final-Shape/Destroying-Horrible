extends KinematicBody2D

export var bullet_speed = 350
export var fire_rate = 1
onready var _animated_sprite = $gunmodel
onready var _gunsmoke = $shootReaction

var bullet = preload("res://Scenes/Bullet.tscn")
var can_fire = true

var mouseposition

func _process(_delta):
	# Aims gun towards mouse
	mouseposition = get_local_mouse_position()
	rotation+= mouseposition.angle() * 1
	
	# Only shoots if gun is vissible
	if Input.is_action_pressed("fire") and can_fire and is_visible():
		
		# Spawns a bullet att the BulletPoint node on the selected weapon.
		# Rotation and force is applied to the bullet to make it fly across the screen
		# can_fire is set to false to prevent unrealistic shooting intervals. Limited by the fire_rare var
		# _animated_sprite plays animations for shooting
		var bullet_instance = bullet.instance()
		bullet_instance.position = $BulletPoint.get_global_position()
		bullet_instance.rotation_degrees = rotation_degrees
		bullet_instance.apply_impulse(Vector2(), Vector2(bullet_speed, 0).rotated(rotation))
		get_tree().get_root().add_child(bullet_instance)
		can_fire = false
		_gunsmoke.play("shoot")
		_animated_sprite.play("Cook")
		yield(get_tree().create_timer(fire_rate), "timeout")
		can_fire = true
		_animated_sprite.play("Idle")
		_gunsmoke.play("idle")
