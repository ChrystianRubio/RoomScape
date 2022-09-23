extends Control


# Declare member variables here. Examples:



#obtendo um objeto do tipo savegame para acessar o banco de dados
var manipulation_acess_dd = SaveGame.new()
var mani
var flag_instance_sword = false
var flag_instance_wood_shield = false
var flag_instance_meet = false
var flag_correct_position = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$optionsLayout/ItemOptions.set_item_icon(0, $ItemsTexture/EquipOptions.texture)
	$optionsLayout/ItemOptions.set_item_icon(1, $ItemsTexture/OutOptions.texture)

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
	$optionsLayout/ItemListSkills.set_item_text(0, "Fight: " + str(manipulation_acess_dd.acess_save(manipulation_acess_dd.path_skills, "")[0]['fight']))
	$optionsLayout/ItemListSkills.set_item_text(1, "Defense: " + str(manipulation_acess_dd.acess_save(manipulation_acess_dd.path_skills, "")[1]['defense']))
	
	
	for slot_bag in range(0, 7):

		#condicao para aparecer na layout da bag, se caso existir na bag bd
		if str(manipulation_acess_dd.acess_save(manipulation_acess_dd.path_bag, "")[slot_bag]["name"]) == "meet":
			$optionsLayout/ItemListBag.set_item_icon(slot_bag, $ItemsTexture/meet.texture ) 
		if str(manipulation_acess_dd.acess_save(manipulation_acess_dd.path_bag, "")[slot_bag]["name"]) == "Sword5":
			$optionsLayout/ItemListBag.set_item_icon(slot_bag, $ItemsTexture/sword1.texture ) 
		elif str(manipulation_acess_dd.acess_save(manipulation_acess_dd.path_bag, "")[slot_bag]["name"]) == "WoodShield":
			$optionsLayout/ItemListBag.set_item_icon(slot_bag, $ItemsTexture/wood_shield.texture ) 
		elif manipulation_acess_dd.acess_save(manipulation_acess_dd.path_bag, "")[slot_bag]["name"] == null:
			$optionsLayout/ItemListBag.set_item_icon(slot_bag, null ) 

		#selecioando o item na bag para equipar/usar
		if $optionsLayout/ItemListBag.is_selected(slot_bag):

			#agora eu to vendo se onde foi selecionado tem icone ou nao
			if $optionsLayout/ItemListBag.get_item_icon(slot_bag) != null:

				#so mostra se bag tiver aberta
				if $optionsLayout/ItemListBag.visible:
					$optionsLayout/ItemOptions.visible = true
				else:
					$optionsLayout/ItemOptions.visible = false
					$optionsLayout/ItemListBag.unselect_all()

				#se selecionar o equipar
				if $optionsLayout/ItemOptions.is_selected(0):
					#agora eu vou deselecionar pq ele nao sai sozinho, podendo dar problema futuramente
					#$optionsLayout/ItemOptions.unselect(0)
					$optionsLayout/ItemListBag.unselect(slot_bag)
					$optionsLayout/ItemOptions.visible = false



					#se for do tipo weapon, equipa no lugar correto
					if manipulation_acess_dd.acess_save(manipulation_acess_dd.path_bag, "")[slot_bag]["weapon"]:
						#estou equipando e ao mesto tempo salvando no banco de dados
						#o equip esta recebendo onde eu to clicando na bag e armazendo nele o resultado
						#somente se o equip estiver nulo
						if manipulation_acess_dd.acess_save(manipulation_acess_dd.path_equip, "")[2]["weapon"] == null:
							#maniEquip é pra pegar no banco de dados o mais recente
							var maniEquip = manipulation_acess_dd.acess_save(manipulation_acess_dd.path_equip, "")
							maniEquip[2] = manipulation_acess_dd.acess_save(manipulation_acess_dd.path_bag, "")[slot_bag]
							#print(manipulation_acess_dd.equip_manipulation[2])
							manipulation_acess_dd.set_save(manipulation_acess_dd.path_equip, maniEquip)
							#somente se equip estiver nulo é que vamos tirar da bag
							mani = manipulation_acess_dd.acess_save(manipulation_acess_dd.path_bag, "")
							mani[slot_bag] = manipulation_acess_dd.default_value_bag[slot_bag]
							manipulation_acess_dd.set_save(manipulation_acess_dd.path_bag, mani)
							$gameEventsLayout/EventsLog.text += manipulation_acess_dd.default_value_game_events["gain_weapon"] + "\n"
						else:
							$gameEventsLayout/EventsLog.text += manipulation_acess_dd.default_value_game_events["already_equipped"] + "\n"

					#se for do tipo shield, equipa no lugar correto
					elif manipulation_acess_dd.acess_save(manipulation_acess_dd.path_bag, "")[slot_bag]["shield"]:
						#estou equipando e ao mesto tempo salvando no banco de dados
						#o equip esta recebendo onde eu to clicando na bag e armazendo nele o resultado
						#somente se o equip estiver nulo
						if manipulation_acess_dd.acess_save(manipulation_acess_dd.path_equip, "")[3]["shield"] == null:
							#maniEquip é pra pegar no banco de dados o mais recente
							var maniEquip = manipulation_acess_dd.acess_save(manipulation_acess_dd.path_equip, "")
							maniEquip[3] = manipulation_acess_dd.acess_save(manipulation_acess_dd.path_bag, "")[slot_bag]
							manipulation_acess_dd.set_save(manipulation_acess_dd.path_equip, maniEquip)
							#somente se equip estiver nulo é que vamos tirar da bag
							mani = manipulation_acess_dd.acess_save(manipulation_acess_dd.path_bag, "")
							mani[slot_bag] = manipulation_acess_dd.default_value_bag[slot_bag]
							manipulation_acess_dd.set_save(manipulation_acess_dd.path_bag, mani)
							$gameEventsLayout/EventsLog.text += manipulation_acess_dd.default_value_game_events["gain_shield"] + "\n"

						else:
							$gameEventsLayout/EventsLog.text += manipulation_acess_dd.default_value_game_events["already_equipped"] + "\n"

					#se for do tipo food, ira consumir
					elif manipulation_acess_dd.acess_save(manipulation_acess_dd.path_bag, "")[slot_bag]["food"]:
						var maniFood = manipulation_acess_dd.acess_save(manipulation_acess_dd.path_status_character, "")
#						#vida do personagem receber mais o health do objeto tipo food
#						maniFood[0]["life"] += manipulation_acess_dd.acess_save(manipulation_acess_dd.path_bag, "")[slot_bag]["health"]
						if maniFood[0]["life"] >= maniFood[1]["max_life"]:
							maniFood[0]["life"] = maniFood[1]["max_life"]
							$gameEventsLayout/EventsLog.text += manipulation_acess_dd.default_value_game_events["full"] + "\n"
						else:
							#vida do personagem receber mais o health do objeto tipo food
							maniFood[0]["life"] += manipulation_acess_dd.acess_save(manipulation_acess_dd.path_bag, "")[slot_bag]["health"]
							$gameEventsLayout/EventsLog.text += manipulation_acess_dd.default_value_game_events["ate the food"] + "\n"
						manipulation_acess_dd.set_save(manipulation_acess_dd.path_status_character, maniFood)
						#tirando da bag
						mani = manipulation_acess_dd.acess_save(manipulation_acess_dd.path_bag, "")
						mani[slot_bag] = manipulation_acess_dd.default_value_bag[slot_bag]
						manipulation_acess_dd.set_save(manipulation_acess_dd.path_bag, mani)

				#se selecionar o jogar no chao
				elif $optionsLayout/ItemOptions.is_selected(1):
					if manipulation_acess_dd.acess_save(manipulation_acess_dd.path_bag, "")[slot_bag]["name"] == "Sword5":
						flag_instance_sword = true
					elif manipulation_acess_dd.acess_save(manipulation_acess_dd.path_bag, "")[slot_bag]["name"] == "WoodShield":
						flag_instance_wood_shield = true
					elif manipulation_acess_dd.acess_save(manipulation_acess_dd.path_bag, "")[slot_bag]["name"] == "meet":
						flag_instance_meet = true
						flag_correct_position = true #necessario para posicao correta na hora de jogar fora
			
					# apos jogar no chao, deletar da bag
					mani = manipulation_acess_dd.acess_save(manipulation_acess_dd.path_bag, "")
					mani[slot_bag] = manipulation_acess_dd.default_value_bag[slot_bag]
					manipulation_acess_dd.set_save(manipulation_acess_dd.path_bag, mani)


					$optionsLayout/ItemOptions.visible = false
					$optionsLayout/ItemListBag.unselect(slot_bag)
			
			
				#deselesionando tudo do options
				$optionsLayout/ItemOptions.unselect_all()


		#5 pq so temos 5 espacos na equip
		if slot_bag < 5:
			
			#selecionando item para desequipar
			if $optionsLayout/ItemListEquip.is_selected(slot_bag):
				
				#deseleciona para nao dar problemas futuros
				$optionsLayout/ItemListEquip.unselect(slot_bag)


				#se o que eu selecionei for diferente de nulo, entao desequipa ele
				if str(manipulation_acess_dd.acess_save(manipulation_acess_dd.path_equip, "")[slot_bag]) != \
				str(manipulation_acess_dd.default_value_equip[slot_bag]):
					mani = manipulation_acess_dd.acess_save(manipulation_acess_dd.path_equip, "")
					var maniBag = manipulation_acess_dd.acess_save(manipulation_acess_dd.path_bag, "")

					#voltando o objeto para a bag
					for slot_bag_back in range(0, 7):
						if str(manipulation_acess_dd.acess_save(manipulation_acess_dd.path_bag, "")[slot_bag_back]) == \
						str(manipulation_acess_dd.default_value_bag[slot_bag_back]):
							maniBag[slot_bag_back] = mani[slot_bag]
							manipulation_acess_dd.set_save(manipulation_acess_dd.path_bag, maniBag)

							#liberando o slot do equip 
							#porem o slot do equip só é liberado se tiver espaço na bag
							mani[slot_bag] = manipulation_acess_dd.default_value_equip[slot_bag]
							manipulation_acess_dd.set_save(manipulation_acess_dd.path_equip, mani)
							
							break # se achar um slot vazio ja para a procura
				
						#se caso nao tiver slot, informe ao usuario isso no log events
						else:
							if slot_bag_back == 6:
								$gameEventsLayout/EventsLog.text += manipulation_acess_dd.default_value_game_events["no_empty_slots"] + "\n"



#	#equips funcionando
	if manipulation_acess_dd.acess_save(manipulation_acess_dd.path_equip, "")[3]["shield"] != null:
		mani = manipulation_acess_dd.acess_save(manipulation_acess_dd.path_status_character, "")
		#se a vida ja tiver cheia e vc equipar um shield, vida fica full junto com a proteção
		if mani[0]["life"] == mani[1]["max_life"]:
			mani[1]["max_life"] = manipulation_acess_dd.default_value_status[0]["life"] + manipulation_acess_dd.acess_save(manipulation_acess_dd.path_equip, "")[3]["defense"]
			mani[0]["life"] = mani[1]["max_life"]
		else:
			mani[1]["max_life"] = manipulation_acess_dd.default_value_status[0]["life"] + manipulation_acess_dd.acess_save(manipulation_acess_dd.path_equip, "")[3]["defense"]
		manipulation_acess_dd.set_save(manipulation_acess_dd.path_status_character, mani)

	else: #volta ao default life e max life
		mani = manipulation_acess_dd.acess_save(manipulation_acess_dd.path_status_character, "")
		mani[1]["max_life"] = manipulation_acess_dd.default_value_status[1]["max_life"]
		# se a vida for maior que o max life atualizado, life recebe o atual max_life
		if mani[0]["life"] > mani[1]["max_life"]:
			mani[0]["life"] = mani[1]["max_life"]
		manipulation_acess_dd.set_save(manipulation_acess_dd.path_status_character, mani)


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


