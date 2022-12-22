extends Node2D

onready var current_weapon = $Revolver

var weapons: Array = []

func _process(_delta):
		
	var mpos = get_global_mouse_position()
	var pos = global_position
	
	var rot = rad2deg((mpos - pos).angle())

	if(rot >= -90 and rot <= 90):
		current_weapon.get_node("AnimatedSprite").flip_v = false
		current_weapon.get_node("BulletPoint").position = Vector2(7, -1)
	else:
		current_weapon.get_node("AnimatedSprite").flip_v = true
		current_weapon.get_node("BulletPoint").position = Vector2(7, 1)

func _ready():
	weapons = get_children()
	
	print (weapons)
	
	for weapon in weapons:
		weapon.hide()
		
	current_weapon.show()
	
func _init():
	return
		
		
func reload():
	return
	
func switch_weapon(weapon):
	if weapon == current_weapon:
		return
		
	current_weapon.hide()
	weapon.show()
	current_weapon = weapon
	
	
func _unhandled_input(event):
	if event.is_action_pressed("weapon_1"): 
		switch_weapon(weapons[0])
	elif event.is_action_pressed("weapon_2"): 
		switch_weapon(weapons[1])
