extends Popup

# Declare member variables here.
onready var ball = get_node("/root/SceneNode/Ball")
var selectedOption

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	if not visible:
		if Input.is_action_just_pressed("pause"):
			# pause the game
			get_tree().paused = true
			# reset popup
			selectedOption = 0
			change_menu_color()
			# show the popup
			ball.set_process_input(false)
			popup_centered()
	else:
		if Input.is_action_just_pressed("ui_down"):
			selectedOption = (selectedOption + 1) % 3
			change_menu_color()
		elif Input.is_action_just_pressed("ui_up"):
			selectedOption -= 1
			if selectedOption < 0:
				selectedOption = 2
			change_menu_color()
		elif Input.is_action_just_pressed("ui_accept"):
			match selectedOption:
				0:
					# resume game
					get_tree().paused = false
					ball.set_process_input(true)
					hide()
				1:
					# restart the game
					get_tree().paused = false
					get_tree().reload_current_scene()
				2:
					# quit and return to menu
					get_tree().paused = false
					get_tree().change_scene("res://Scenes/main_menu.tscn")
		elif Input.is_action_just_pressed("pause"):
			get_tree().paused = false
			ball.set_process_input(true)
			hide()

func change_menu_color():
	$Resume.color = Color.white
	$Restart.color = Color.white
	$Quit.color = Color.white
	
	match selectedOption:
		0:
			$Resume.color = Color.greenyellow
		1:
			$Restart.color = Color.greenyellow
		2:
			$Quit.color = Color.greenyellow
