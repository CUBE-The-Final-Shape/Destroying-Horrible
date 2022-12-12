extends KinematicBody2D

export (int) var speed = 100
export (int) var jump_strength = 200
export (int) var gravity = 800
export (int) var max_health = 100

var path: Array = []
var navigation: Navigation2D = null
var player = null

var roam = false

var velocity = Vector2(0, 0)

func _ready():
	if get_tree().has_group("Navigation"):
		navigation = get_tree().get_nodes_in_group("Navigation")[0]
	if get_tree().has_group("player"):
		player = get_tree().get_nodes_in_group("player")[0]
	
func _physics_process(delta):
	if player and navigation:
		generatePath()
		navigate()
	
	move_character()
	
func navigate():
	if path.size() > 0:
		velocity = global_position.direction_to(path[1]) * speed
		
		if global_position == path[0]:
			path.pop_front()
	
func generatePath():
	if navigation != null and player != null:
		path = navigation.get_simple_path(global_position, player.global_position, false)
	
func move_character():
	velocity = move_and_slide(velocity, Vector2.UP)
