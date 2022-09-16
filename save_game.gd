extends Node

class_name SaveGame

# O caminho dos saves 
var path_game_events = "user://game_events.save"
var path_bag = "user://character_bag.save"
var path_skills = "user://character_skills.save"
var path_equip = "user://character_equip.save"




####################################################################################################

# eventos 

var default_value_game_events = {
	"text_exit": "Are you sure you want to exit?",

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
	"attack": 0,
	"defense": 0,
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

}

var bag_manipulation = acess_save(path_bag, default_value_bag)

#methods getters and setters da bag
func getBag_manipulation():
	return bag_manipulation

func setBag_manipulation(var bag_manipulation):
	self.bag_manipulation = bag_manipulation


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

