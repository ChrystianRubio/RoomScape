extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var pontuacao = 0

var sairTexto = {
	"text":"quer sair mesmo ramelao??",
	"pontuacao": "0",
}

var path = "user://textJsonTeste3.save"


# Called when the node enters the scene tree for the first time.
func _ready():
	#set_json()
	#get_user_current()
	#set_save()
	acess_save()
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#acess_save()
	pass


func _on_ButtonConfig_pressed():
	pontuacao += 1
	sairTexto[pontuacao] = str(pontuacao)
	#sairTexto["pontuacao"] = str(pontuacao)
	#acess_save()
	set_save()
	print(pontuacao)
	if $optionsLayout/ButtonExit.visible:
		$optionsLayout/ButtonExit.visible = false

	else:
		$optionsLayout/ButtonExit.visible = true
		#$gameEventsLayout/EventsLog.text = str('Are you sure you want to exit?')
		#$gameEventsLayout/EventsLog.text = str(userCurrent["text"])
	$gameEventsLayout/EventsLog.text = str(sairTexto)

func _on_ButtonExit_pressed():
	$".".get_tree().quit()




#fazendo uma funcao para o proprio godot criar o save
func set_save():
	var file = File.new()
	# abrindo o arquivo em forma de leitura para salvar dados
	file.open(path, file.WRITE)
	file.store_var(sairTexto)
	file.close()



# fazendo uma função para acessar o save
func acess_save():
	var file = File.new()
	#verificando se o arquivo existe ou nao
	if not file.file_exists(path):
		sairTexto = {
			"text":"deseja sair mesmo ?",
			"pontuacao": "0",
		}
		set_save() # se nao existir o resultado do dict acima é o valor default

	#estamos lendo o arquivo
	file.open(path, file.READ)
	sairTexto = file.get_var()
	file.close()






