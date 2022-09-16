extends TouchScreenButton


# Declare member variables here. Examples:

#obtendo um objto para manipulacao 
var acess_save = SaveGame.new()


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Sword_pressed():
	acess_save.bag_manipulation["sword"] = 1
	$".".queue_free()  #destroindo o nó após presionar na sword
	print(acess_save.getBag_manipulation())
	pass # Replace with function body.
