extends Control


# Declare member variables here. Examples:



#obtendo um objeto do tipo savegame para acessar o banco de dados
var manipulation_acess_dd = SaveGame.new()



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	#colocando as skiils corretas no layout skills
	$optionsLayout/ItemListSkills.set_item_text(0, "Attack: " + str(manipulation_acess_dd.acess_save(manipulation_acess_dd.path_skills, "")[0]['attack']))
	$optionsLayout/ItemListSkills.set_item_text(1, "Defense: " + str(manipulation_acess_dd.acess_save(manipulation_acess_dd.path_skills, "")[1]['defense']))
	
	
	for slot_bag in range(0, 7):
		#condicao para aparecer na layout da bag, se caso existir na bag bd
		if str(manipulation_acess_dd.acess_save(manipulation_acess_dd.path_bag, "")[slot_bag]["name"]) == "Sword5":
			$optionsLayout/ItemListBag.set_item_icon(slot_bag, $ItemsTexture/sword1.texture ) 

		if str(manipulation_acess_dd.acess_save(manipulation_acess_dd.path_bag, "")[slot_bag]["name"]) == "WoodShield":
			$optionsLayout/ItemListBag.set_item_icon(slot_bag, $ItemsTexture/wood_shield.texture ) 



	for slot_bag in range(0, 7):
		# selecionando itens na bag para equip
		if $optionsLayout/ItemListBag.is_selected(slot_bag):

			# se for do tipo weapon vai para equip weapon
			if manipulation_acess_dd.acess_save(manipulation_acess_dd.path_bag, "")[slot_bag]["weapon"]:
				# no campo 2 pq é o weapon
				manipulation_acess_dd.equip_manipulation[2] = manipulation_acess_dd.acess_save(manipulation_acess_dd.path_bag, "")[slot_bag]

				
			# se for do tipo shield vai para equip shield
			if manipulation_acess_dd.acess_save(manipulation_acess_dd.path_bag, "")[slot_bag]["shield"]:
				# no campo 3 pq é o weapon
				manipulation_acess_dd.equip_manipulation[3] = manipulation_acess_dd.acess_save(manipulation_acess_dd.path_bag, "")[slot_bag]


			manipulation_acess_dd.set_save(manipulation_acess_dd.path_equip, manipulation_acess_dd.equip_manipulation) #setando no banco de dados apos todos os equips


	# tera que ter um if para cada parte do equip
	# se for diferente de nulo entra no if
	# é necessario esse if pq o [name] so existe depois que colocarmos um equip
	
	#mostrando em layout equip nossos equipamentos de cada parte do corpo
	if str(manipulation_acess_dd.equip_manipulation[2]["weapon"]) != "Null":
		$optionsLayout/ItemListEquip.set_item_text(2, 
											str(manipulation_acess_dd.equip_manipulation[2]["name"] +
											str(manipulation_acess_dd.equip_manipulation[2]["damage"])
											))
	
	if str(manipulation_acess_dd.equip_manipulation[3]["shield"]) != "Null":
		#$optionsLayout/ItemListEquip.set_item_icon(3, $ItemsTexture/shieldEquip.texture)
		$optionsLayout/ItemListEquip.set_item_text(3, 
											str(manipulation_acess_dd.equip_manipulation[3]["name"] +
											str(manipulation_acess_dd.equip_manipulation[3]["defense"])
											))


	pass


# botao config presionado
func _on_ButtonConfig_pressed():
	
	#os outro botoes desaparecem se estiverem visiveis
	$optionsLayout/ItemListBag.visible = false
	$optionsLayout/ItemListEquip.visible = false
	$optionsLayout/ItemListSkills.visible = false

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
	
	#os outro botoes desaparecem se estiverem visiveis
	$optionsLayout/ItemListBag.visible = false
	$optionsLayout/ItemListEquip.visible = false
	$optionsLayout/ButtonExit.visible = false

	if $optionsLayout/ItemListSkills.visible:
		$optionsLayout/ItemListSkills.visible = false
	else:
		$optionsLayout/ItemListSkills.visible = true
	pass # Replace with function body.


#botao bag presionado
func _on_ButtonBag_pressed():
	#os outro botoes desaparecem se estiverem visiveis
	$optionsLayout/ItemListEquip.visible = false
	$optionsLayout/ItemListSkills.visible = false
	$optionsLayout/ButtonExit.visible = false

	if $optionsLayout/ItemListBag.visible:
		$optionsLayout/ItemListBag.visible = false
	else:
		$optionsLayout/ItemListBag.visible = true
	pass # Replace with function body.


#botao equip pressionado
func _on_ButtonEquip_pressed():
	
	#os outro botoes desaparecem se estiverem visiveis
	$optionsLayout/ItemListBag.visible = false
	$optionsLayout/ItemListSkills.visible = false
	$optionsLayout/ButtonExit.visible = false
	
	if $optionsLayout/ItemListEquip.visible:
		$optionsLayout/ItemListEquip.visible = false
	else:
		$optionsLayout/ItemListEquip.visible = true
	pass # Replace with function body.
