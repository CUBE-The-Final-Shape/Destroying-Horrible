extends Node2D

onready var current_weapon = $Revolver

var weapons: Array = []

func _ready():
	weapons = get_children()
	
	print (weapons)
	
	for weapon in weapons:
		weapon.hide()
		
	current_weapon.show()
	print (current_weapon)
	print (weapons[1])
	
	
func _init():
	return
		
		
func reload():
	return
	
func switch_weapon(weapon):
	print(weapon)
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
