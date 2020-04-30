extends KinematicBody2D


# Declare member variables here. Examples:
export var speed = 400
var current_speed = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	set_physics_process(true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if Input.is_action_pressed("move_up"):
		current_speed = -1*speed
		move_and_slide(Vector2(0,current_speed))
	elif Input.is_action_pressed("move_down"):
		current_speed = speed
		move_and_slide(Vector2(0,current_speed))
	else:
		current_speed = 0
