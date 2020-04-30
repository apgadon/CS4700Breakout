extends RigidBody2D

# Declare member variables here.
var started = false
var gameOver = false
const SPEED_UP = 8
const MAX_SPEED = 600
var barSpeed = 0
var xSpeed = 300
var ySpeed = 300
var lives = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	set_physics_process(true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	# ball has not been launched yet
	if !started:
		# launch the ball (left-click)
		if Input.is_mouse_button_pressed(1) and !gameOver:
			# ball is in play
			started = true
			set_linear_velocity(Vector2(xSpeed, ySpeed))
		# move ball with paddle
		else:
			if get_node("/root/Node2D/Paddles/paddle3").is_on_wall():
				barSpeed = 0
			else:
				barSpeed = get_node("/root/Node2D/Paddles/paddle3").current_speed
			set_linear_velocity(Vector2(0, barSpeed))
	# game logic
	elif !gameOver:
		var bodies = get_colliding_bodies()
		
		for body in bodies:
			if body.is_in_group("bricks"):
				$Block.play()
				body.queue_free()
				
			if body.is_in_group("paddles"):
				$Bar.play()
				var speed = get_linear_velocity().length()
				var dir = get_position() - body.get_node("CollisionShape2D/Anchor").get_global_position()
				var velocity = dir.normalized() * min(speed + SPEED_UP, MAX_SPEED)
				set_linear_velocity(velocity)
			else:
				$Wall.play()
	# game over logic
	else:
		if Input.is_mouse_button_pressed(2):
			get_tree().reload_current_scene()

func _integrate_forces(state):
	if is_out_of_bounds():
		$Lose.play()
		started = false
		lives = lives - 1
		if lives <= 0:
			gameOver = true
		state.set_transform(Transform2D(0.0, Vector2(37, get_node("/root/Node2D/Paddles/paddle3/CollisionShape2D").get_global_position().y)))

func is_out_of_bounds():
	return get_position().y > get_viewport_rect().end.y or get_position().y < 0 or get_position().x > get_viewport_rect().end.x or get_position().x < 0
