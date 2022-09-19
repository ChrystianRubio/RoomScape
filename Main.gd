extends Node2D


# Declare member variables here. 



# Called when the node enters the scene tree for the first time.
func _ready():
	$itemsButtonScreen/Sword.position.x = 0
	$itemsButtonScreen/Sword.position.y = 0
	$itemsButtonScreen/Sword.visible = true
	$itemsButtonScreen/WoodShield.position.x = 50
	$itemsButtonScreen/WoodShield.position.y = -50
	$itemsButtonScreen/WoodShield.visible = true
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):

#	pass



const spaw_spider = preload("res://Scorpion.tscn")
var limit = 1

func _on_TimerScorpion_timeout():
	if limit <= 5:
		add_child(spaw_spider.instance())
		limit += 1


	pass # Replace with function body.



func _on_Main_child_exiting_tree(node):
	
	if node.is_in_group("Scorpion"):
		# se for o scorpion que morreu o limit recebe -1
		limit -= 1  #toda vez que morrer um nasce outro


		if $KinematicBody2D/AnimatedSprite.animation == "up_attack":
			$KinematicBody2D/AnimatedSprite.play("up_idle")
		elif $KinematicBody2D/AnimatedSprite.animation == "down_attack":
			$KinematicBody2D/AnimatedSprite.play("down_idle")
		elif $KinematicBody2D/AnimatedSprite.animation == "side_attack":
			$KinematicBody2D/AnimatedSprite.play("side_idle")

	pass # Replace with function body.


