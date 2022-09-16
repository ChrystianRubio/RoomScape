extends Node

class_name SaveGame

var path_game_events = "user://game_events.save"
var path_bag = "user://character_bag.save"
var path_skills = "user://character_skills.save"
var path_equip = "user://character_equip.save"

####################################################################################################
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



####################################################################################################

var default_value_skills = {
	"attack": 0,
	"defense": 0,
}

var value_skills_manipulation = acess_save(path_skills, default_value_skills)

#methods getters and setters dos skills
func getSkills_manipulation():
	return value_skills_manipulation

func setValue_skills_manipulation(var value_skills_manipulation):
	self.value_skills_manipulation = value_skills_manipulation
####################################################################################################

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
		#sairTexto = {
		#	"text_exit": "Are you sure you want to exit?",
		#}
		set_save(path, default_value) # se nao existir o resultado do if, o dict acima é o valor default

	#estamos lendo o arquivo
	file.open(path, file.READ)
	var manipulation = file.get_var()
	file.close()
	return manipulation







