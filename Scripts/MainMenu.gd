extends Control

# switches scene from main menu to the actual game
func _on_Start_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/Main.tscn")

# closes the game
func _on_Quit_pressed():
	get_tree().quit()
