extends TouchScreenButton


# Declare member variables here. Examples:

#obtendo um objto para manipulacao 
var manipulation_save = SaveGame.new()


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Sword_pressed():

	var mani = manipulation_save.acess_save(manipulation_save.path_bag, "") #mani é o intermediador da manipulacao neste file
	
	
	for slot_bag in range(0,7):
		#se for nulo podera armazenar o objeto
		if manipulation_save.acess_save(manipulation_save.path_bag, "")[slot_bag]["name"] == null:
			mani[slot_bag] = {"name" : "Sword5", "damage": 1, "defense": 0, "weapon": true, "shield": false}
			manipulation_save.set_save(manipulation_save.path_bag,mani)
			break
	
	

	
	#$".".queue_free()  #destroindo o nó após presionar na sword
	pass # Replace with function body.
