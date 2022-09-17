extends Control


# Declare member variables here. Examples:



#obtendo um objeto do tipo savegame para acessar o banco de dados
var manipulation_acess_dd = SaveGame.new()



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	for slot_bag in range(0, 7):
		#condicao para aparecer na layout da bag, se caso existir na bag bd
		if str(manipulation_acess_dd.acess_save(manipulation_acess_dd.path_bag, "")[slot_bag]["name"]) == "Sword5":
			$optionsLayout/ItemListBag.set_item_icon(slot_bag, $ItemsTexture/sword1.texture ) 

		if str(manipulation_acess_dd.acess_save(manipulation_acess_dd.path_bag, "")[slot_bag]["name"]) == "WoodShield":
			$optionsLayout/ItemListBag.set_item_icon(slot_bag, $ItemsTexture/wood_shield.texture ) 

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
	manipulation_acess_dd.acess_save(manipulation_acess_dd.path_bag, "")

	print(manipulation_acess_dd.acess_save(manipulation_acess_dd.path_bag, ""))


	if $optionsLayout/ItemListBag.visible:
		$optionsLayout/ItemListBag.visible = false
	else:
		$optionsLayout/ItemListBag.visible = true
	pass # Replace with function body.


#botao equip pressionado
func _on_ButtonEquip_pressed():
	
	if $optionsLayout/ItemListEquip.is_selected(0):
		print($optionsLayout/ItemListEquip.get_item_text(0))
	#print($optionsLayout/ItemListEquip.is_selected(0))
	#print($optionsLayout/ItemListEquip.get_selected_items())
	#print($optionsLayout/ItemListEquip.get_item_text())
	
	if $optionsLayout/ItemListEquip.visible:
		$optionsLayout/ItemListEquip.visible = false
	else:
		$optionsLayout/ItemListEquip.visible = true
	pass # Replace with function body.
