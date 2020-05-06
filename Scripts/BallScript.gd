extends KinematicBody2D

export var speed = 400
export var ySpeed = 0
export var xSpeed = 0
var count = 0
var mul = 1
var active = false
var gover = false
var ball_medium = preload("res://Assets/player_1.png")
var ball_fast = preload("res://Assets/player_2.png")
onready var ball_sprite = get_node("CollisionShape2D/Sprite")
var lives = 3

func reset():
	speed = 400
	set_position(Vector2(get_node("/root/SceneNode/Bar/Mid").position.x, 553.187))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !active:
		if Input.is_action_pressed("move_right_1"):
			move_and_slide(Vector2(speed,0))
		elif Input.is_action_pressed("move_left_1"):
			move_and_slide(Vector2(-1*speed,0))
		if Input.is_action_pressed("launch"):
			speed = 350
			ySpeed = -325 * mul;
			xSpeed = 0;
			active = true;
	elif !gover:
		move_and_slide(Vector2(xSpeed, ySpeed), Vector2(0, -1))
		for i in get_slide_count():
			var collision = get_slide_collision(0)
#			print("Collided with: ", collision.collider.name)
			if (collision.collider.name == "Box"):
				$Block.play()
				count += 1
				if (count == 45):
					ball_sprite.set_texture(ball_medium)
					mul = 1.5
					ySpeed *= mul
				elif (count == 90):
					ball_sprite.set_texture(ball_fast)
					ySpeed /= mul
					mul = 2
					ySpeed *= mul
				collision.collider.whenHit()
			if (collision.collider.name == "Wall" || collision.collider.name == "Wall2" || collision.collider.name == "Wall3"):
				$Wall.play()
			if (collision.collider.name == "Floor"):
				xSpeed = 0
				ySpeed = 0
				$Lose.play()
				lives -= 1
				active = false
				reset()
				# print("Game Over!")
				if lives == 0:
					gover = true
			if (collision.collider.name == "LMid" || collision.collider.name == "LMid2"):
				$Bar.play()
				xSpeed = -100 * mul
			elif (collision.collider.name == "RMid" || collision.collider.name == "RMid2"):
				$Bar.play()
				xSpeed = 100 * mul
			elif (collision.collider.name == "LLMid" || collision.collider.name == "LLMid2"):
				$Bar.play()
				xSpeed = -200 * mul
			elif (collision.collider.name == "RRMid" || collision.collider.name == "RRMid2"):
				$Bar.play()
				xSpeed = 200 * mul
			elif (collision.collider.name == "LLLMid" || collision.collider.name == "LLLMid2"):
				$Bar.play()
				xSpeed = -300 * mul
			elif (collision.collider.name == "RRRMid" || collision.collider.name == "RRRMid2"):
				$Bar.play()
				xSpeed = 300 * mul
			elif (collision.collider.name == "LLLLMid" || collision.collider.name == "LLLLMid2"):
				$Bar.play()
				xSpeed = -400 * mul
			elif (collision.collider.name == "RRRRMid" || collision.collider.name == "RRRRMid2"):
				$Bar.play()
				xSpeed = 400 * mul
			elif (collision.collider.name == "Left" || collision.collider.name == "Left2"):
				$Bar.play()
				xSpeed = -500 * mul
			elif (collision.collider.name == "Right" || collision.collider.name == "Right2"):
				$Bar.play()
				xSpeed = 500 * mul
			elif (collision.collider.name == "Mid" || collision.collider.name == "Mid2"):
				$Bar.play()
				xSpeed = 0
		if is_on_wall():
			xSpeed *= -1
		if is_on_ceiling() || is_on_floor():
			ySpeed *= -1
