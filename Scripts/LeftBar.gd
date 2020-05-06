extends KinematicBody2D

export var speed = 400
var gover = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !gover:
		if Input.is_action_pressed("move_down_1"):
			move_and_slide(Vector2(0,speed))
		elif Input.is_action_pressed("move_up_1"):
			move_and_slide(Vector2(0,-1*speed))
	
