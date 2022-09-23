extends Node

class_name SaveGame

# O caminho dos saves 
var path_game_events = "user://game_events15.save"
var path_bag = "user://character_bag79.save"
var path_skills = "user://character_skills21save"
var path_equip = "user://character_equip118.save"
var path_status_character = "user://character_status27.save"



####################################################################################################

# eventos 

var default_value_game_events = {
	"text_exit": "Are you sure you want to exit?",
	"get_item": "you took an item",
	"damage": "you are taking damage",
	"hit": "you are hitting",
	"healthLife": "+1 health",
	"no_empty_slots": "don't have any empty slots",
	"already_equipped": "you already have something equipped",
	"gain_shield": "you equipped a shield",
	"gain_weapon": "you equipped a weapon",
	"lost_bag": "you lost everything in your bag",
	"full": "you are full",
	"ate the food": "you ate the food",
}

var value_game_events_manipulation = acess_save(path_game_events, default_value_game_events)

#methods getters and setters
func getValue_game_events_manipulation():
	return value_game_events_manipulation

func setValue_game_events_manipulation(var value_game_events_manipulation):
	self.value_game_events_manipulation = value_game_events_manipulation


####################################################################################################

# skills

var default_value_skills = {
	0: {"fight": 0},
	1: {"defense": 0},
}

var value_skills_manipulation = acess_save(path_skills, default_value_skills)

#methods getters and setters das skills
func getSkills_manipulation():
	return value_skills_manipulation

func setValue_skills_manipulation(var value_skills_manipulation):
	self.value_skills_manipulation = value_skills_manipulation


####################################################################################################

# bag

var default_value_bag = {
	0: {"name": null, },
	1: {"name": null, },
	2: {"name": null, },
	3: {"name": null, },
	4: {"name": null, },
	5: {"name": null, },
	6: {"name": null, },
	#6: {"name": null, "weapon": false, "shield": false},

}

var bag_manipulation = acess_save(path_bag, default_value_bag)

#methods getters and setters da bag
func getBag_manipulation():
	return bag_manipulation

func setBag_manipulation(var bag_manipulation):
	self.bag_manipulation = bag_manipulation


####################################################################################################

# equip

var default_value_equip = {
	0: {"head": null},
	1: {"armor": null},
	2: {"weapon": null},
	3: {"shield": null},
	4: {"feet": null},
}

var equip_manipulation = acess_save(path_equip, default_value_equip)

#methods getters and setters do equip
func getEquip_manipulation():
	return equip_manipulation

func setEquip_manipulation(var equip_manipulation):
	self.equip_manipulation = equip_manipulation


####################################################################################################

# status character

var default_value_status = {
	0: {"life": 10},
	1: {"max_life": 10},
}

var status_manipulation = acess_save(path_status_character, default_value_status)

#methods getters and setters do equip
func getStatus_manipulation():
	return equip_manipulation

func setStatus_manipulation(var status_manipulation):
	self.status_manipulation = status_manipulation


####################################################################################################


# funcoes para modificar e acessar os saves

#fazendo uma funcao para o proprio godot criar o save
func set_save(var path, var value):
	var file = File.new()
	# abrindo o arquivo em forma de leitura para salvar dados
	file.open(path, file.WRITE)
	file.store_var(value)
	file.close()


# fazendo uma função para acessar o save
func acess_save(var path, var default_value):
	var file = File.new()
	#verificando se o arquivo existe ou nao
	if not file.file_exists(path):

		set_save(path, default_value) # se nao existir o resultado do if, 
									  #chama set para ter os valores default

	#estamos lendo o arquivo
	file.open(path, file.READ)
	var manipulation = file.get_var()
	file.close()
	return manipulation # retornando essa variavel para fazer mnipulacao, após a manipulacao ser
	# ser feita devemos setar(set_save)  


####################################################################################################

