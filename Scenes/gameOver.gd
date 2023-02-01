extends Control
var is_paused = false setget set_is_paused

func _ready():
	var player = get_tree().get_root().find_node("Player",true,false)
	player.connect("killed", self, "gameOver")
	
func gameOver():
	self.is_paused = !is_paused

func set_is_paused(value):
	is_paused = value
	get_tree().paused = is_paused
	visible = is_paused

func _on_Main_menu_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/MainMenu.tscn")
	

func _on_Restart_pressed():
# warning-ignore:return_value_discarded
	get_tree().reload_current_scene()

func _on_Quit_pressed():
	get_tree().quit()
