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

