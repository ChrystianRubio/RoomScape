extends Node2D


# Declare member variables here. Examples:
#obtendo um objeto do tipo savegame para acessar o banco de dados
var manipulation_acess_dd = SaveGame.new()


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

	get_tree().change_scene("res://Main.tscn")
	pass # Replace with function body.
