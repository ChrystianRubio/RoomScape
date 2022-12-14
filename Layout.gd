extends Control


# Declare member variables here. Examples:



#obtendo um objeto do tipo savegame para acessar o banco de dados
var manipulation_acess_dd = SaveGame.new()
var mani
var quantify_gold = 0


var flag_instance_sword = false
var flag_instance_wood_shield = false
var flag_instance_meet = false
var flag_instance_gold = false
var flag_instance_iron_sword = false
var flag_instance_reforced_wood_shield = false
var flag_instance_simple_axe = false
var flag_instance_wood = false

var flag_correct_position = false




# Called when the node enters the scene tree for the first time.
func _ready():
	#equipar ou jogar fora
	$optionsLayout/ItemOptions.set_item_icon(0, $ItemsTexture/EquipOptions.texture)
	$optionsLayout/ItemOptions.set_item_icon(1, $ItemsTexture/OutOptions.texture)

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	
	#mostrando em layout equip nossos equipamentos de cada parte do corpo
	if manipulation_acess_dd.acess_save(manipulation_acess_dd.path_equip, "")[2]["weapon"] != null:
		$optionsLayout/ItemListEquip.set_item_text(2, str(manipulation_acess_dd.acess_save(manipulation_acess_dd.path_equip, "")[2]["damage"]))
		if manipulation_acess_dd.acess_save(manipulation_acess_dd.path_equip, "")[2]["name"] == "Sword5":
			$optionsLayout/ItemListEquip.set_item_icon(2, $ItemsTexture/sword1.texture)
		elif manipulation_acess_dd.acess_save(manipulation_acess_dd.path_equip, "")[2]["name"] == "iron_sword":
			$optionsLayout/ItemListEquip.set_item_icon(2, $ItemsTexture/iron_sword.texture)
		elif manipulation_acess_dd.acess_save(manipulation_acess_dd.path_equip, "")[2]["name"] == "simple_axe":
			$optionsLayout/ItemListEquip.set_item_icon(2, $ItemsTexture/simple_axe.texture)
	else:
		$optionsLayout/ItemListEquip.set_item_text(2,"")
		$optionsLayout/ItemListEquip.set_item_icon(2, null)


	if manipulation_acess_dd.acess_save(manipulation_acess_dd.path_equip, "")[3]["shield"] != null:
		$optionsLayout/ItemListEquip.set_item_text(3, str(manipulation_acess_dd.acess_save(manipulation_acess_dd.path_equip, "")[3]["defense"]))
		if manipulation_acess_dd.acess_save(manipulation_acess_dd.path_equip, "")[3]["name"] ==  "WoodShield":
			$optionsLayout/ItemListEquip.set_item_icon(3, $ItemsTexture/wood_shield.texture)
		elif manipulation_acess_dd.acess_save(manipulation_acess_dd.path_equip, "")[3]["name"] ==  "reforced_wood_shield":
			$optionsLayout/ItemListEquip.set_item_icon(3, $ItemsTexture/reforced_wood_shield.texture)
	else:
		$optionsLayout/ItemListEquip.set_item_text(3,"")
		$optionsLayout/ItemListEquip.set_item_icon(3, null)


	
	#colocando as skiils corretas no layout skills
	set_level(0, "fight", "level_up_fight")
	set_level(1, "woodcutting", "level_up_woodcutting")
	$optionsLayout/ItemListSkills.set_item_text(0, "Fight: " + str(manipulation_acess_dd.acess_save(manipulation_acess_dd.path_skills, "")[0]['fight']["level_current"]))
	$optionsLayout/ItemListSkills.set_item_text(1, "woodcutting: " + str(manipulation_acess_dd.acess_save(manipulation_acess_dd.path_skills, "")[1]['woodcutting']["level_current"]))

	#mostrando next xp e level no log apos apetar nas skilss
	for slot_skill in range(0, 2):
		if $optionsLayout/ItemListSkills.is_selected(slot_skill):
			$optionsLayout/ItemListSkills.unselect_all()

			if slot_skill == 0:
				var percent = int((manipulation_acess_dd.acess_save(manipulation_acess_dd.path_skills, "")[slot_skill]["fight"]["xp_current"] /\
			  	manipulation_acess_dd.acess_save(manipulation_acess_dd.path_skills, "")[slot_skill]["fight"]["xp_next"]) * 100.0)

				$gameEventsLayout/EventsLog.text += "\t\t\t\t\t\t\tFight: " + str(manipulation_acess_dd.acess_save(manipulation_acess_dd.path_skills, "")[slot_skill]["fight"]["level_current"]) + "\n"
				$gameEventsLayout/EventsLog.text += "xp: " + \
				str(manipulation_acess_dd.acess_save(manipulation_acess_dd.path_skills, "")[slot_skill]["fight"]["xp_current"]) + "\n" + \
				"next_xp_level: " + str(manipulation_acess_dd.acess_save(manipulation_acess_dd.path_skills, "")[slot_skill]["fight"]["xp_next"]) + "\n" + \
				"percentage: " + str(percent) + "%" + "\n" + "################################" + "\n" 

			elif slot_skill == 1:
				var percent = int((manipulation_acess_dd.acess_save(manipulation_acess_dd.path_skills, "")[slot_skill]["woodcutting"]["xp_current"] /\
			  	manipulation_acess_dd.acess_save(manipulation_acess_dd.path_skills, "")[slot_skill]["woodcutting"]["xp_next"]) * 100.0)

				$gameEventsLayout/EventsLog.text += "\t\t\t\t\t\tWoodcutting: " + str(manipulation_acess_dd.acess_save(manipulation_acess_dd.path_skills, "")[slot_skill]["woodcutting"]["level_current"]) + "\n"
				$gameEventsLayout/EventsLog.text += "xp: " + \
				str(manipulation_acess_dd.acess_save(manipulation_acess_dd.path_skills, "")[slot_skill]["woodcutting"]["xp_current"]) + "\n" + \
				"next_xp_level: " + str(manipulation_acess_dd.acess_save(manipulation_acess_dd.path_skills, "")[slot_skill]["woodcutting"]["xp_next"]) + "\n" + \
				"percentage: " + str(percent) + "%" + "\n" + "################################" + "\n" 

		#$optionsLayout/ItemListEquip.unselect_all()
			#break

	#comprando na loja buy
	for slot_store in range(0, 5):
		if $optionsLayout/ItemListStore.is_selected(slot_store):
			
			if $optionsLayout/ItemListStore.visible:
				$optionsLayout/ItemOptionsBuy.visible = true
			else:
				$optionsLayout/ItemOptionsBuy.visible = false
			#se selecionar o equipar
			if $optionsLayout/ItemOptionsBuy.is_selected(1):

				#agora eu vou deselecionar pq ele nao sai sozinho, podendo dar problema futuramente
				$optionsLayout/ItemOptionsBuy.unselect(1)

				mani = manipulation_acess_dd.acess_save(manipulation_acess_dd.path_bag, "")
				var flag_buy = false
				var flag_slot = false
				var value_items = [3, 3, 3, 1, 1] #todos os valores do itens terao que ficar aqui em ordem
				#a loja ?? de forma statica
				for slot_bag in range(0, 7):
					if str(mani[slot_bag]) != str(manipulation_acess_dd.default_value_bag[slot_bag]):
						if mani[slot_bag]["name"] == "gold": # se tiver gold
								for x in range(0, 7): 
									if str(mani[x]) == str(manipulation_acess_dd.default_value_bag[x]): # se tiver slot vazio na bag
										flag_buy = true
										break
									if x >= 6:
										$gameEventsLayout/EventsLog.text += manipulation_acess_dd.default_value_game_events["no_empty_slots"] + "\n"
								if flag_buy: # cobrando
									if mani[slot_bag]["gold"] >= value_items[slot_store]:
										mani[slot_bag]["gold"] -= value_items[slot_store]
										flag_slot = true
									else:
										$gameEventsLayout/EventsLog.text += manipulation_acess_dd.default_value_game_events["no_money"] + "\n"

								break

				if flag_buy and flag_slot:
					for slot_bag in range(0, 7):
							if str(mani[slot_bag]) == str(manipulation_acess_dd.default_value_bag[slot_bag]):

								if slot_store == 0:
									mani[slot_bag] = {"name" : "iron_sword", "damage": 3, "defense": 0, "health": 0, "gold": 0,"wood": false , "weapon": true, "shield": false, "food": false}
									#mani[slot_bag]["gold"] -= 3
									$gameEventsLayout/EventsLog.text += manipulation_acess_dd.default_value_game_events["buy_iron_sword"] + "\n"

								elif slot_store == 1:
									mani[slot_bag] = {"name" : "reforced_wood_shield", "damage": 0, "defense": 3, "health": 0, "gold": 0,"wood": false , "weapon": false, "shield": true, "food": false}
									#mani[slot_bag]["gold"] -= 3
									$gameEventsLayout/EventsLog.text += manipulation_acess_dd.default_value_game_events["buy_reforced_wood_shield"] + "\n"

								elif slot_store == 2:
									mani[slot_bag] =  {"name" : "simple_axe", "damage": 1, "defense": 0, "health": 0, "gold": 0,"wood": true , "weapon": true, "shield": false, "food": false}
									#mani[slot_bag]["gold"] -= 3
									$gameEventsLayout/EventsLog.text += manipulation_acess_dd.default_value_game_events["buy_simple_axe"] + "\n"
		
								elif slot_store == 3:
									mani[slot_bag] =  {"name" : "meet", "damage": 0, "defense": 0, "health": 3,"gold": 0,"wood": false, "weapon": false, "shield": false, "food": true}
									#mani[slot_bag]["gold"] -= 3
									$gameEventsLayout/EventsLog.text += manipulation_acess_dd.default_value_game_events["buy_meat"] + "\n"
								
								elif slot_store == 4:
									mani[slot_bag] = {"name" : "wood", "damage": 0, "defense": 0, "health": 0, "gold": 0,"wood": false, "weapon": false, "shield": false, "food": false}
									#mani[slot_bag]["gold"] -= 3
									$gameEventsLayout/EventsLog.text += manipulation_acess_dd.default_value_game_events["buy_wood"] + "\n"
								flag_buy = false
								break
				
				$optionsLayout/ItemOptionsBuy.unselect_all()
				$optionsLayout/ItemOptionsBuy.visible = false
				$optionsLayout/ItemListStore.unselect_all()
				manipulation_acess_dd.set_save(manipulation_acess_dd.path_bag, mani)

			elif $optionsLayout/ItemOptionsBuy.is_selected(0):
				$optionsLayout/ItemOptionsBuy.unselect_all()
				$optionsLayout/ItemOptionsBuy.visible = false
				$optionsLayout/ItemListStore.unselect_all()

	#vendendo na loja sell
	for slot_store in range(0, 5):
		if $optionsLayout/ItemListStoreSell.is_selected(slot_store):
			#colocando visivel
			if $optionsLayout/ItemListStoreSell.visible:
				$optionsLayout/ItemOptionsSell.visible = true
			else:
				$optionsLayout/ItemOptionsSell.visible = false
			#se selecionar o equipar
			if $optionsLayout/ItemOptionsSell.is_selected(1):
				#agora eu vou deselecionar pq ele nao sai sozinho, podendo dar problema futuramente
				$optionsLayout/ItemOptionsSell.unselect(1)
				mani = manipulation_acess_dd.acess_save(manipulation_acess_dd.path_bag, "")
				var flag_have_item = false
				var value_items = [3, 3, 3, 1, 1] #todos os valores do itens terao que ficar aqui em ordem

				#procurando na bag se eu tenho o objeto selecionado
				for slot_bag in range(0, 7):
					if slot_store == 0 and mani[slot_bag]["name"] == "iron_sword":
							flag_have_item = true
							mani[slot_bag] = manipulation_acess_dd.default_value_bag[slot_bag]
							$gameEventsLayout/EventsLog.text += manipulation_acess_dd.default_value_game_events["sell_iron_sword"] + "\n"
							break # necessario para pegar somente uma no caso de o persogem ter mais na bag
					elif slot_store == 1 and mani[slot_bag]["name"] == "reforced_wood_shield":
							flag_have_item = true
							mani[slot_bag] = manipulation_acess_dd.default_value_bag[slot_bag]
							$gameEventsLayout/EventsLog.text += manipulation_acess_dd.default_value_game_events["sell_reforced_wood_shield"] + "\n"
							break
					elif slot_store == 2 and mani[slot_bag]["name"] == "simple_axe":
							flag_have_item = true
							mani[slot_bag] = manipulation_acess_dd.default_value_bag[slot_bag]
							$gameEventsLayout/EventsLog.text += manipulation_acess_dd.default_value_game_events["sell_simple_axe"] + "\n"
							break
					elif slot_store == 3 and mani[slot_bag]["name"] == "meet":
							flag_have_item = true
							mani[slot_bag] = manipulation_acess_dd.default_value_bag[slot_bag]
							$gameEventsLayout/EventsLog.text += manipulation_acess_dd.default_value_game_events["sell_meat"] + "\n"
							break
					elif slot_store == 4 and mani[slot_bag]["name"] == "wood":
							flag_have_item = true
							mani[slot_bag] = manipulation_acess_dd.default_value_bag[slot_bag]
							$gameEventsLayout/EventsLog.text += manipulation_acess_dd.default_value_game_events["sell_wood"] + "\n"
							break


				for slot_bag in range(0, 7):
						#se eu tiver eu preciso verificar se tenho gold ou nao
						if flag_have_item:
							if mani[slot_bag]["name"] == "gold": # se eu ja tiver gold, faz a soma e break
								mani[slot_bag]["gold"] += value_items[slot_store]
								break
							if slot_bag == 6: # se chegou ate aqui significa que nao achou gold em nenhum dos slots
								for slot in range(0, 7): # entao verifica se tem lugar e se tiver lugar na bag coloque o gold ja com o valor do objeto clicado e break
									if mani[slot]["name"] == null:
										mani[slot] = {"name" : "gold", "damage": 0, "defense": 0, "health": 0, "gold": value_items[slot_store] ,"wood": false, "weapon": false, "shield": false, "food": false}
										break

				$optionsLayout/ItemOptionsSell.unselect_all()
				$optionsLayout/ItemOptionsSell.visible = false
				$optionsLayout/ItemListStoreSell.unselect_all()
				manipulation_acess_dd.set_save(manipulation_acess_dd.path_bag, mani)
			elif $optionsLayout/ItemOptionsSell.is_selected(0):
				$optionsLayout/ItemOptionsSell.unselect_all()
				$optionsLayout/ItemOptionsSell.visible = false
				$optionsLayout/ItemListStoreSell.unselect_all()

	#bag
	for slot_bag in range(0, 7):

		#condicao para aparecer na layout da bag, se caso existir na bag bd
		if str(manipulation_acess_dd.acess_save(manipulation_acess_dd.path_bag, "")[slot_bag]["name"]) == "wood":
			$optionsLayout/ItemListBag.set_item_icon(slot_bag, $ItemsTexture/wood.texture )
		if str(manipulation_acess_dd.acess_save(manipulation_acess_dd.path_bag, "")[slot_bag]["name"]) == "simple_axe":
			$optionsLayout/ItemListBag.set_item_icon(slot_bag, $ItemsTexture/simple_axe.texture ) 
		if str(manipulation_acess_dd.acess_save(manipulation_acess_dd.path_bag, "")[slot_bag]["name"]) == "reforced_wood_shield":
			$optionsLayout/ItemListBag.set_item_icon(slot_bag, $ItemsTexture/reforced_wood_shield.texture ) 
		if str(manipulation_acess_dd.acess_save(manipulation_acess_dd.path_bag, "")[slot_bag]["name"]) == "iron_sword":
			$optionsLayout/ItemListBag.set_item_icon(slot_bag, $ItemsTexture/iron_sword.texture ) 
		if str(manipulation_acess_dd.acess_save(manipulation_acess_dd.path_bag, "")[slot_bag]["name"]) == "gold":
			$optionsLayout/ItemListBag.set_item_icon(slot_bag, $ItemsTexture/gold.texture ) 
			$optionsLayout/ItemListBag.set_item_text(slot_bag, str(manipulation_acess_dd.acess_save(manipulation_acess_dd.path_bag, "")[slot_bag]["gold"]))
			quantify_gold = manipulation_acess_dd.acess_save(manipulation_acess_dd.path_bag, "")[slot_bag]["gold"] # para  dropar todos
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
							#maniEquip ?? pra pegar no banco de dados o mais recente
							var maniEquip = manipulation_acess_dd.acess_save(manipulation_acess_dd.path_equip, "")
							maniEquip[2] = manipulation_acess_dd.acess_save(manipulation_acess_dd.path_bag, "")[slot_bag]
							#print(manipulation_acess_dd.equip_manipulation[2])
							manipulation_acess_dd.set_save(manipulation_acess_dd.path_equip, maniEquip)
							#somente se equip estiver nulo ?? que vamos tirar da bag
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
							#maniEquip ?? pra pegar no banco de dados o mais recente
							var maniEquip = manipulation_acess_dd.acess_save(manipulation_acess_dd.path_equip, "")
							maniEquip[3] = manipulation_acess_dd.acess_save(manipulation_acess_dd.path_bag, "")[slot_bag]
							manipulation_acess_dd.set_save(manipulation_acess_dd.path_equip, maniEquip)
							#somente se equip estiver nulo ?? que vamos tirar da bag
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
					elif manipulation_acess_dd.acess_save(manipulation_acess_dd.path_bag, "")[slot_bag]["name"] == "gold":
						$optionsLayout/ItemListBag.set_item_text(slot_bag, "")
						# o mundo que estiver so vai instanciar outra se gold for maior que zero
						if manipulation_acess_dd.acess_save(manipulation_acess_dd.path_bag, "")[slot_bag]["gold"] > 0:
							flag_instance_gold = true
							flag_correct_position = true #necessario para posicao correta na hora de jogar fora
					elif manipulation_acess_dd.acess_save(manipulation_acess_dd.path_bag, "")[slot_bag]["name"] == "iron_sword":
						flag_instance_iron_sword = true
						flag_correct_position = true #necessario para posicao correta na hora de jogar fora
					elif manipulation_acess_dd.acess_save(manipulation_acess_dd.path_bag, "")[slot_bag]["name"] == "reforced_wood_shield":
						flag_instance_reforced_wood_shield = true
						flag_correct_position = true #necessario para posicao correta na hora de jogar fora
					elif manipulation_acess_dd.acess_save(manipulation_acess_dd.path_bag, "")[slot_bag]["name"] == "simple_axe":
						flag_instance_simple_axe = true
						flag_correct_position = true #necessario para posicao correta na hora de jogar fora
					elif manipulation_acess_dd.acess_save(manipulation_acess_dd.path_bag, "")[slot_bag]["name"] == "wood":
						flag_instance_wood = true
						flag_correct_position = true #necessario para posicao correta na hora de jogar fora
			
					# apos jogar no chao, deletar da bag
					mani = manipulation_acess_dd.acess_save(manipulation_acess_dd.path_bag, "")
					mani[slot_bag] = manipulation_acess_dd.default_value_bag[slot_bag]
					manipulation_acess_dd.set_save(manipulation_acess_dd.path_bag, mani)


					$optionsLayout/ItemOptions.visible = false
					$optionsLayout/ItemListBag.unselect(slot_bag)
			
			
				#deselesionando tudo do options
				$optionsLayout/ItemOptions.unselect_all()

			else: # se caso selecionar algo vazio
				$optionsLayout/ItemOptions.visible = false
				$optionsLayout/ItemListBag.unselect_all()

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
							#porem o slot do equip s?? ?? liberado se tiver espa??o na bag
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
		#se a vida ja tiver cheia e vc equipar um shield, vida fica full junto com a prote????o
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


#setando o level do personagem com base no xp_current
func set_level(var location, var skill, var level_up_msg):
	mani = manipulation_acess_dd.acess_save(manipulation_acess_dd.path_skills, "")
	#var flag_level_up = false
	if mani[location][skill]["xp_current"] < 100:
		mani[location][skill]["level_current"] = 1
		mani[location][skill]["xp_next"] = 200
	elif mani[location][skill]["xp_current"] >= 100 and mani[location][skill]["xp_current"] < 200 :
		mani[location][skill]["level_current"] = 2
		mani[location][skill]["xp_next"] = 400
	elif mani[location][skill]["xp_current"] >= 200 and mani[location][skill]["xp_current"] < 400 :
		mani[location][skill]["level_current"] = 3
		mani[location][skill]["xp_next"] = 800
	elif mani[location][skill]["xp_current"] >= 400 and mani[location][skill]["xp_current"] < 800 :
		mani[location][skill]["level_current"] = 4
		mani[location][skill]["xp_next"] = 1500
	elif mani[location][skill]["xp_current"] >= 800 and mani[location][skill]["xp_current"] < 1500 :
		mani[location][skill]["level_current"] = 5
		mani[location][skill]["xp_next"] = 2600
	elif mani[location][skill]["xp_current"] >= 1500 and mani[location][skill]["xp_current"] < 2600 :
		mani[location][skill]["level_current"] = 6
		mani[location][skill]["xp_next"] = 4200
	elif mani[location][skill]["xp_current"] >= 2600 and mani[location][skill]["xp_current"] < 4200 :
		mani[location][skill]["level_current"] = 7
		mani[location][skill]["xp_next"] = 6400
	elif mani[location][skill]["xp_current"] >= 4200 and mani[location][skill]["xp_current"] < 6400 :
		mani[location][skill]["level_current"] = 8
		mani[location][skill]["xp_next"] = 9300
	elif mani[location][skill]["xp_current"] >= 6400 and mani[location][skill]["xp_current"] < 9300 :
		mani[location][skill]["level_current"] = 9
		mani[location][skill]["xp_next"] = 9300
	elif mani[location][skill]["xp_current"] >= 9300 and mani[location][skill]["xp_current"] < 13000 :
		mani[location][skill]["level_current"] = 10
		mani[location][skill]["xp_next"] = 13000
	elif mani[location][skill]["xp_current"] >= 13000 and mani[location][skill]["xp_current"] < 17600 :
		mani[location][skill]["level_current"] = 11
		mani[location][skill]["xp_next"] = 17600
	elif mani[location][skill]["xp_current"] >= 17600 and mani[location][skill]["xp_current"] < 23200 :
		mani[location][skill]["level_current"] = 12
		mani[location][skill]["xp_next"] = 23200
	elif mani[location][skill]["xp_current"] >= 23200 and mani[location][skill]["xp_current"] < 29900 :
		mani[location][skill]["level_current"] = 13
		mani[location][skill]["xp_next"] = 29900
	elif mani[location][skill]["xp_current"] >= 29900 and mani[location][skill]["xp_current"] < 37800 :
		mani[location][skill]["level_current"] = 14
		mani[location][skill]["xp_next"] = 37800
	elif mani[location][skill]["xp_current"] >= 37800: #and mani[location][skill]["xp_current"] < 17600 :
		mani[location][skill]["level_current"] = 15
		#mani[location][skill]["xp_next"] = 37800

	#aparecendo uma mensagem de level up no log
	if mani[location][skill]["level_current"] > manipulation_acess_dd.acess_save(manipulation_acess_dd.path_skills, "")[location][skill]["level_current"]:
		$gameEventsLayout/EventsLog.text += manipulation_acess_dd.default_value_game_events[level_up_msg] + str(mani[location][skill]["level_current"]) + "\n"

	manipulation_acess_dd.set_save(manipulation_acess_dd.path_skills, mani)

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
		$optionsLayout/ItemListSkills.unselect_all()
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


