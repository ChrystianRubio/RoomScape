extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

export (int) var speed = 200

var velocity = Vector2()

func get_input():
	velocity = Vector2()

	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
		$AnimatedSprite.flip_h = true
		$AnimatedSprite.play("side_walk")
	elif Input.is_action_just_released("ui_right"):
		$AnimatedSprite.play("side_idle")


	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
		$AnimatedSprite.flip_h = false
		$AnimatedSprite.play("side_walk")
	elif Input.is_action_just_released("ui_left"):
		$AnimatedSprite.play("side_idle")


	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
		$AnimatedSprite.play("down_walk")
	elif Input.is_action_just_released("ui_down"):
		$AnimatedSprite.play("down_idle")


	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
		$AnimatedSprite.play("up_walk")
	elif Input.is_action_just_released("ui_up"):
		$AnimatedSprite.play("up_idle")


	velocity = velocity.normalized() * speed

func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
