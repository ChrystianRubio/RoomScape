extends TouchScreenButton


# Declare member variables here. Examples:
#obtendo um objto para manipulacao 
var manipulation_save = SaveGame.new()
var flag_near = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



func _on_Gold_pressed():
	
	var mani = manipulation_save.acess_save(manipulation_save.path_bag, "") #mani é o intermediador da manipulacao neste file
	

	var flag_slot_empty = false
	if flag_near:
		for slot_bag in range(0,7):

			#parte do agrupamento
			#if manipulation_save.acess_save(manipulation_save.path_bag, "")[slot_bag]["name"] != null:
			if manipulation_save.acess_save(manipulation_save.path_bag, "")[slot_bag]["name"] == "gold":
				mani[slot_bag]["gold"] += 1
				manipulation_save.set_save(manipulation_save.path_bag, mani)
				flag_slot_empty = false
				$".".queue_free()  #destroindo o nó após presionar 
				break
			else:
				flag_slot_empty = true

		if flag_slot_empty :
			for slot_bag in range(0, 7):
					#se for nulo podera armazenar o objeto
					if manipulation_save.acess_save(manipulation_save.path_bag, "")[slot_bag]["name"] == null:
						mani[slot_bag] = {"name" : "gold", "damage": 0, "defense": 0, "health": 0, "gold": 1,"wood": false, "weapon": false, "shield": false, "food": false}
						manipulation_save.set_save(manipulation_save.path_bag,mani)
						$".".queue_free()  #destroindo o nó após presionar 
						break

	pass # Replace with function body.


func _on_Area2D_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if body:
		if body.name == "KinematicBody2D":
			flag_near = true

	pass # Replace with function body.


func _on_Area2D_body_shape_exited(body_rid, body, body_shape_index, local_shape_index):
	if body:
		if body.name == "KinematicBody2D":
			flag_near = false
	pass # Replace with function body.

