extends Control


# Declare member variables here. Examples:



#obtendo um objeto do tipo savegame para acessar o banco de dados
var manipulation_acess_dd = SaveGame.new()



# Called when the node enters the scene tree for the first time.
func _ready():

#	acess_save()
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#acess_save()
	pass


# botao config presionado
func _on_ButtonConfig_pressed():

	if $optionsLayout/ButtonExit.visible:
		$optionsLayout/ButtonExit.visible = false

	else:
		$optionsLayout/ButtonExit.visible = true
		$gameEventsLayout/EventsLog.text += str(manipulation_acess_dd.getValue_game_events_manipulation()['text_exit'] + "\n")


#botao sair presionado
func _on_ButtonExit_pressed():
	$".".get_tree().quit()



#botao skills presionado
func _on_ButtonSkills_pressed():
	#colocando o level das skills ao lado do icon

	$optionsLayout/ItemListSkills.set_item_text(0, "Attack: " + str(manipulation_acess_dd.value_skills_manipulation['attack']))
	$optionsLayout/ItemListSkills.set_item_text(1, "Defense: " + str(manipulation_acess_dd.value_skills_manipulation['defense']))
	if $optionsLayout/ItemListSkills.visible:
		$optionsLayout/ItemListSkills.visible = false
	else:
		$optionsLayout/ItemListSkills.visible = true
	pass # Replace with function body.


#botao bag presionado
func _on_ButtonBag_pressed():
	$optionsLayout/ItemListBag.set_item_icon(0, $Sword1.texture ) 
	#$optionsLayout/ItemListBag.set_item

	if $optionsLayout/ItemListBag.visible:
		$optionsLayout/ItemListBag.visible = false
	else:
		$optionsLayout/ItemListBag.visible = true
	pass # Replace with function body.
