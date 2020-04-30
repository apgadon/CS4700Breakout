extends RigidBody2D

# Declare member variables here.
var started = false
var gameOver = false
const SPEED_UP = 8
const MAX_SPEED = 600
var barSpeed = 0
var xSpeed = 300
var ySpeed = -300
var lives = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	set_physics_process(true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	# ball has not been launched yet
	if !started and !gameOver:
		# launch the ball (left-click)
		if Input.is_mouse_button_pressed(1):
			# ball is in play
			started = true
			set_linear_velocity(Vector2(xSpeed, ySpeed))
		# move ball with paddle
		else:
			if get_node("/root/Node2D/Paddle").is_on_wall():
				barSpeed = 0
			else:
				barSpeed = get_node("/root/Node2D/Paddle").current_speed
			set_linear_velocity(Vector2(barSpeed, 0))
	# game logic
	elif !gameOver:
		var bodies = get_colliding_bodies()
		
		for body in bodies:
			if body.is_in_group("bricks"):
				$Block.play()
				body.queue_free()
				
			if body.get_name() == "Paddle":
				$Bar.play()
				var speed = get_linear_velocity().length()
				var dir = get_position() - body.get_node("Anchor").get_global_position()
				var velocity = dir.normalized() * min(speed + SPEED_UP, MAX_SPEED)
				set_linear_velocity(velocity)
			else:
				$Wall.play()
	# game over logic
	else:
		if Input.is_mouse_button_pressed(2):
			get_tree().reload_current_scene()

func _integrate_forces(state):
		if get_position().y > get_viewport_rect().end.y:
			$Lose.play()
			started = false
			lives = lives - 1
			if lives <= 0:
				$Lose.stop()
				gameOver = true
				set_linear_velocity(Vector2(0, 0))
			else:
				state.set_transform(Transform2D(0.0, Vector2(get_node("/root/Node2D/Paddle").get_global_position().x, 555)))