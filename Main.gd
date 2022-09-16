extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	#var x = SaveGame.new()
	#var modificando = x.getValue_game_events_manipulation()
	#modificando["lauis"] = "tatat"
	#x.setValue_game_events_manipulation(modificando)
	#$KinematicBody2D/Layout/gameEventsLayout/EventsLog.text += str(x.getValue_game_events_manipulation())
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

"""
var path_game_events = "user://game_events.save"
var path_bag = "user://character_bag.save"
var path_skills = "user://character_skills.save"
var path_equip = "user://character_equip.save"


var default_value_game_events = {
	"text_exit": "Are you sure you want to exit?",

}

var value_game_events_manipulation = acess_save(path_game_events, default_value_game_events, value_game_events_manipulation)



#fazendo uma funcao para o proprio godot criar o save
func set_save(var path, var value):
	var file = File.new()
	# abrindo o arquivo em forma de leitura para salvar dados
	file.open(path, file.WRITE)
	file.store_var(value)
	file.close()


# fazendo uma função para acessar o save
func acess_save(var path, var default_value, var manipulation):
	var file = File.new()
	#verificando se o arquivo existe ou nao
	if not file.file_exists(path):
		#sairTexto = {
		#	"text_exit": "Are you sure you want to exit?",
		#}
		set_save(path, default_value) # se nao existir o resultado do if, o dict acima é o valor default

	#estamos lendo o arquivo
	file.open(path, file.READ)
	manipulation = file.get_var()
	file.close()
	return manipulation

"""








"""
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
	value_game_events_manipulation = file.get_var()
	file.close()
"""
