extends Node2D


# Declare member variables here. Examples:
#obtendo um objeto do tipo savegame para acessar o banco de dados
var manipulation_acess_dd = SaveGame.new()


# Called when the node enters the scene tree for the first time.
func _ready():
	#obtendo a cidade onde paramos da ultima vez
	if manipulation_acess_dd.acess_save(manipulation_acess_dd.path_status_character, "")[2]["main"]["current"]:
		get_tree().change_scene("res://Main.tscn")

	elif manipulation_acess_dd.acess_save(manipulation_acess_dd.path_status_character, "")[2]["cave_one"]["current"]:
		get_tree().change_scene("res://CaveOne.tscn")
	elif manipulation_acess_dd.acess_save(manipulation_acess_dd.path_status_character, "")[2]["store_one"]["current"]:
		get_tree().change_scene("res://StoreOne.tscn")
	elif manipulation_acess_dd.acess_save(manipulation_acess_dd.path_status_character, "")[2]["death_city"]["current"]:
		get_tree().change_scene("res://Death_City.tscn")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
