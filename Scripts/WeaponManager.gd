extends Node2D
# This weapon manager was designed so that the game supports multiple weapons and can be updated to support more
onready var current_weapon = $Revolver

# The storage of weapons is done using an array defined below
var weapons: Array = []

func _process(_delta):
		
	var mpos = get_global_mouse_position()
	var pos = global_position
	
	var rot = rad2deg((mpos - pos).angle())

	# flips gun depending on cursor location so that it always faces right side up
	if(rot >= -90 and rot <= 90):
		current_weapon.get_node("gunmodel").flip_v = false
		current_weapon.get_node("BulletPoint").position = Vector2(7, -1)
		current_weapon.get_node("shootReaction").position = Vector2(12, -1)
	else:
		current_weapon.get_node("gunmodel").flip_v = true
		current_weapon.get_node("BulletPoint").position = Vector2(7, 1)
		current_weapon.get_node("shootReaction").position = Vector2(12, 0)

func _ready():
	# the array is created from the children of the WeaponManager node on the player scene
	# The first weapon is the first child the second weapon is the second child and so on
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
