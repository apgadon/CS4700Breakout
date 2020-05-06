extends StaticBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var health = 3
var block_happy = preload("res://Assets/block3_0.png")
var block_nonplussed = preload("res://Assets/block3_1.png")
var block_scared = preload("res://Assets/block3_2.png")
onready var block_sprite = get_node("CollisionShape2D/Sprite")


# Called when the node enters the scene tree for the first time.
func _ready():
	block_sprite.set_texture(block_happy)
#	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func whenHit():
	health -= 1
	if (health == 2):
		block_sprite.set_texture(block_nonplussed)
	elif (health == 1):
		block_sprite.set_texture(block_scared)
	elif (health == 0):
		queue_free()
