extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

#var pontuacao = 0

#var sairTexto = {
#	"text":"quer sair mesmo ramelao??",
#	"pontuacao": "0",
#}

#var path = "user://textJsonTeste3.save"

#obtendo um objeto do tipo savegame para acessar o banco de dados
var manipulation_acess_dd = SaveGame.new()

# Called when the node enters the scene tree for the first time.
func _ready():

#	acess_save()
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#acess_save()
	pass


func _on_ButtonConfig_pressed():

	if $optionsLayout/ButtonExit.visible:
		$optionsLayout/ButtonExit.visible = false

	else:
		$optionsLayout/ButtonExit.visible = true
		$gameEventsLayout/EventsLog.text = str(manipulation_acess_dd.getValue_game_events_manipulation()['text_exit'])
		#$gameEventsLayout/EventsLog.text = str('Are you sure you want to exit?')
		#$gameEventsLayout/EventsLog.text = str(userCurrent["text"])
		#$gameEventsLayout/EventsLog.text = str(sairTexto)

func _on_ButtonExit_pressed():
	$".".get_tree().quit()




func _on_ButtonSkills_pressed():
	#colocando o texto nos itens

	$optionsLayout/ItemList.set_item_text(0, "Attack: " + str(manipulation_acess_dd.value_skills_manipulation['attack']))
	$optionsLayout/ItemList.set_item_text(1, "Defense: " + str(manipulation_acess_dd.value_skills_manipulation['defense']))
	if $optionsLayout/ItemList.visible:
		$optionsLayout/ItemList.visible = false
	else:
		$optionsLayout/ItemList.visible = true
	pass # Replace with function body.
