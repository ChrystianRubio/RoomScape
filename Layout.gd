extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	#set_json()
	get_user_current()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_ButtonConfig_pressed():
	if $optionsLayout/ButtonExit.visible:
		$optionsLayout/ButtonExit.visible = false
	else:
		$optionsLayout/ButtonExit.visible = true
		#$gameEventsLayout/EventsLog.text = str('Are you sure you want to exit?')
		$gameEventsLayout/EventsLog.text = str(userCurrent["text"])

func _on_ButtonExit_pressed():
	$".".get_tree().quit()



#func for acess data base json
var userCurrent_data = File.new()
var userCurrent =  {}


#getting path for *json
func get_user_current():
	if userCurrent_data.file_exists("textJsonTeste.json"):
		userCurrent_data.open("textJsonTeste.json", File.READ)
		userCurrent = parse_json(userCurrent_data.get_as_text())
		userCurrent_data.close()
		#userPath = str("users/" + userCurrent["userCurrent"] + "/")
		print(userCurrent)


#fazendo uma funcao para o proprio godot criar um json

var sairTexto = {
	"text":"quer sair mesmo ramelao??",
}

var path = "textJsonTeste1.json"

func set_json():
	var file = File.new()
	file.open(path, file.WRITE)
	file.store_var(sairTexto)
	file.close()

