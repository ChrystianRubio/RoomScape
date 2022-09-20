extends Control


# Declare member variables here. Examples:



#obtendo um objeto do tipo savegame para acessar o banco de dados
var manipulation_acess_dd = SaveGame.new()
var mani


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	
		#mostrando em layout equip nossos equipamentos de cada parte do corpo
	if manipulation_acess_dd.acess_save(manipulation_acess_dd.path_equip, "")[2]["weapon"] != null:
		$optionsLayout/ItemListEquip.set_item_text(2, 
											str(manipulation_acess_dd.acess_save(manipulation_acess_dd.path_equip, "")[2]["name"] +
											str(manipulation_acess_dd.acess_save(manipulation_acess_dd.path_equip, "")[2]["damage"])
											))
	else:
		$optionsLayout/ItemListEquip.set_item_text(2,"")


	if manipulation_acess_dd.acess_save(manipulation_acess_dd.path_equip, "")[3]["shield"] != null:
		$optionsLayout/ItemListEquip.set_item_text(3, 
											str(manipulation_acess_dd.acess_save(manipulation_acess_dd.path_equip, "")[3]["name"] +
											str(manipulation_acess_dd.acess_save(manipulation_acess_dd.path_equip, "")[3]["defense"])
											))
	else:
		$optionsLayout/ItemListEquip.set_item_text(3,"")


	
	#colocando as skiils corretas no layout skills
	$optionsLayout/ItemListSkills.set_item_text(0, "Fight: " + str(manipulation_acess_dd.acess_save(manipulation_acess_dd.path_skills, "")[0]['attack']))
	$optionsLayout/ItemListSkills.set_item_text(1, "Defense: " + str(manipulation_acess_dd.acess_save(manipulation_acess_dd.path_skills, "")[1]['defense']))
	
	
	for slot_bag in range(0, 7):

		#condicao para aparecer na layout da bag, se caso existir na bag bd
		if str(manipulation_acess_dd.acess_save(manipulation_acess_dd.path_bag, "")[slot_bag]["name"]) == "Sword5":
			$optionsLayout/ItemListBag.set_item_icon(slot_bag, $ItemsTexture/sword1.texture ) 
		elif str(manipulation_acess_dd.acess_save(manipulation_acess_dd.path_bag, "")[slot_bag]["name"]) == "WoodShield":
			$optionsLayout/ItemListBag.set_item_icon(slot_bag, $ItemsTexture/wood_shield.texture ) 
		elif manipulation_acess_dd.acess_save(manipulation_acess_dd.path_bag, "")[slot_bag]["name"] == null:
			$optionsLayout/ItemListBag.set_item_icon(slot_bag, null ) 


		#selecioando o item na bag para equipar
		if $optionsLayout/ItemListBag.is_selected(slot_bag):

			#agora eu vou deselecionar pq ele nao sai sozinho, podendo dar problema futuramente
			$optionsLayout/ItemListBag.unselect(slot_bag)
			
			#agora eu to vendo se onde foi selecionado tem icone ou nao
			if $optionsLayout/ItemListBag.get_item_icon(slot_bag) != null:
				#se for do tipo weapon, equipa no lugar correto
				if manipulation_acess_dd.acess_save(manipulation_acess_dd.path_bag, "")[slot_bag]["weapon"]:
					#estou equipando e ao mesto tempo salvando no banco de dados
					#o equip esta recebendo onde eu to clicando na bag e armazendo nele o resultado
					#somente se o equip estiver nullo
					if manipulation_acess_dd.acess_save(manipulation_acess_dd.path_equip, "")[2]["weapon"] == null:
						manipulation_acess_dd.equip_manipulation[2] = manipulation_acess_dd.acess_save(manipulation_acess_dd.path_bag, "")[slot_bag]
						print(manipulation_acess_dd.equip_manipulation[2])
						manipulation_acess_dd.set_save(manipulation_acess_dd.path_equip, manipulation_acess_dd.equip_manipulation)
						#somente se equip estiver nulo é que vamos tirar da bag
						var mani = manipulation_acess_dd.acess_save(manipulation_acess_dd.path_bag, "")
						mani[slot_bag] = manipulation_acess_dd.default_value_bag[slot_bag]
						manipulation_acess_dd.set_save(manipulation_acess_dd.path_bag, mani)

				#se for do tipo shield, equipa no lugar correto
				elif manipulation_acess_dd.acess_save(manipulation_acess_dd.path_bag, "")[slot_bag]["shield"]:
					#estou equipando e ao mesto tempo salvando no banco de dados
					#o equip esta recebendo onde eu to clicando na bag e armazendo nele o resultado
					#somente se o equip estiver nullo
					if manipulation_acess_dd.acess_save(manipulation_acess_dd.path_equip, "")[3]["shield"] == null:
						manipulation_acess_dd.equip_manipulation[3] = manipulation_acess_dd.acess_save(manipulation_acess_dd.path_bag, "")[slot_bag]
						manipulation_acess_dd.set_save(manipulation_acess_dd.path_equip, manipulation_acess_dd.equip_manipulation)
						#somente se equip estiver nulo é que vamos tirar da bag
						var mani = manipulation_acess_dd.acess_save(manipulation_acess_dd.path_bag, "")
						mani[slot_bag] = manipulation_acess_dd.default_value_bag[slot_bag]
						manipulation_acess_dd.set_save(manipulation_acess_dd.path_bag, mani)



		#5 pq so temos 5 espacos na equip
		if slot_bag < 5:
			
			#selecionando item para desequipar
			if $optionsLayout/ItemListEquip.is_selected(slot_bag):
				
				#deseleciona para nao dar problemas futuros
				$optionsLayout/ItemListEquip.unselect(slot_bag)

				#se o que eu selecionei for diferente de nulo, entao desequipa ele
				if str(manipulation_acess_dd.acess_save(manipulation_acess_dd.path_equip, "")[slot_bag]) != \
				str(manipulation_acess_dd.default_value_equip[slot_bag]):
					var mani = manipulation_acess_dd.acess_save(manipulation_acess_dd.path_equip, "")
					mani[slot_bag] = manipulation_acess_dd.default_value_equip[slot_bag]
					print(mani)
					manipulation_acess_dd.set_save(manipulation_acess_dd.path_equip, mani)
			
"""
		# DESEQUIPAR E AQUI E NAO TA FUNCIONANDO CORRETAMENTE
		#pq 5 e o total de slot do equip
		if slot_bag < 5:
			#selecionando itens para desequipar
			if $optionsLayout/ItemListEquip.is_selected(slot_bag):
			#	#importante deselecionar logo depois
				$optionsLayout/ItemListEquip.unselect(slot_bag)
				
				#a verificacao aqui será feita banco de dados do equip
				if manipulation_acess_dd.acess_save(manipulation_acess_dd.path_equip, "")[2]["weapon"] != null:
					mani = manipulation_acess_dd.acess_save(manipulation_acess_dd.path_equip, "")
					mani[slot_bag] = manipulation_acess_dd.default_value_equip[slot_bag] #recebendo nulo no equip que foi selecionado para desequipar 
					manipulation_acess_dd.set_save(manipulation_acess_dd.path_equip, mani)

				elif manipulation_acess_dd.acess_save(manipulation_acess_dd.path_equip, "")[3]["shield"] != null:
					mani = manipulation_acess_dd.acess_save(manipulation_acess_dd.path_equip, "")
					mani[slot_bag] = manipulation_acess_dd.default_value_equip[slot_bag] #recebendo nulo no equip que foi selecionado para desequipar 
					manipulation_acess_dd.set_save(manipulation_acess_dd.path_equip, mani)


"""
	# tera que ter um if para cada parte do equip
	# se for diferente de nulo entra no if
	# é necessario esse if pq o [][tipo] so existe depois que colocarmos um equip
	




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
