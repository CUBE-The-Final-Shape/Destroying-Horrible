extends KinematicBody2D

signal killed()
signal health_updated(health)

export (int) var speed = 150
export (int) var max_health = 100
onready var health = max_health setget _set_health

var velocity = Vector2()

func get_input():
	velocity = Vector2()
	if Input.is_action_pressed('right'):
		velocity.x += 1
	if Input.is_action_pressed('left'):
		velocity.x -= 1
	if Input.is_action_pressed('down'):
		velocity.y += 1
	if Input.is_action_pressed('up'):
		velocity.y -= 1
	velocity = velocity.normalized() * speed
	
	if Input.is_action_pressed("k"):
		damage(10)
		

func _physics_process(delta):
	print(health)
	get_input()
	velocity = move_and_slide(velocity)
	
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
