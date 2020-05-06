extends Popup

onready var ball = get_node("/root/SceneNode/Ball")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	if not visible:
		if ball.gover:
			get_tree().paused = true
			ball.set_process_input(false)
			popup_centered()
	else:
		if Input.is_action_just_pressed("reset"):
			get_tree().paused = false
			ball.set_process_input(true)
			get_tree().reload_current_scene()
