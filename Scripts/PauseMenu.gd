extends Control

var is_paused = false setget set_is_paused

func _unhandled_input(event):
	if event.is_action_pressed("pause"):
		self.is_paused = !is_paused

func set_is_paused(value):
	is_paused = value
	get_tree().paused = is_paused
	visible = is_paused

# unpauses the game
func _on_Resume_pressed():
	self.is_paused = false

# changes scene to main menu
func _on_Main_menu_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/MainMenu.tscn")

# close the game
func _on_Quit_pressed():
	get_tree().quit()
