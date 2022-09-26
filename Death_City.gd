extends Node2D


# Declare member variables here. Examples:
#obtendo um objeto do tipo savegame para acessar o banco de dados
var manipulation_acess_dd = SaveGame.new()
var mani

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.play("idle")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_TouchScreenButton_pressed():
	#tirando tudo que tem na bag
	manipulation_acess_dd.bag_manipulation = manipulation_acess_dd.default_value_bag
	manipulation_acess_dd.set_save(manipulation_acess_dd.path_bag, manipulation_acess_dd.bag_manipulation)
	
	mani = manipulation_acess_dd.acess_save(manipulation_acess_dd.path_status_character, "")
	mani[2]["main"]["current"] = false
	mani[2]["cave_one"]["current"] = false
	mani[2]["store_one"]["current"] = false
	mani[2]["death_city"]["current"] = true
	mani[2]["main"]["positionX"] = -3488
	mani[2]["main"]["positionY"] = -331
	manipulation_acess_dd.set_save(manipulation_acess_dd.path_status_character, mani)

	get_tree().change_scene("res://Main.tscn")
	pass # Replace with function body.


func _on_Death_City_child_entered_tree(node):
		#definindo onde o personagem esta para futuras seções

	pass # Replace with function body.


func _on_Death_City_child_exiting_tree(node):
	pass # Replace with function body.
