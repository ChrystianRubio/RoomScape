extends KinematicBody2D


# Declare member variables here. Examples:
#obtendo um objeto do tipo savegame para acessar o banco de dados
var manipulation_acess_dd = SaveGame.new()


var attack = 1
var life = 2
var xp = 15
var flagNear = false #uma flag para conseguir somente atacar quando estiver perto


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.play("idle")
	#inicializando o valor max da vida 
	$TextureProgress.max_value = life
	
	#posicao x e y aleatoria
	position.x = rand_range(-2404, -2748)
	position.y = rand_range(-6, -227)

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#mostrando progress bar com a vida 
	$TextureProgress.value = life

	#verificando se tiver arma equipada o screenAction recece a animacao de atacar
	#se nao recebe nulo
	if manipulation_acess_dd.acess_save(manipulation_acess_dd.path_equip, "")[2]["weapon"] != null and flagNear:
		$TouchScreenButton.action = "ui_space"
	else:
		$TouchScreenButton.action = ""

#	pass


func _on_TouchScreenButton_pressed():
	#enquanto nao tiver equipado algo na weapon nao comeca o timer
	if manipulation_acess_dd.acess_save(manipulation_acess_dd.path_equip, "")[2]["weapon"] != null and flagNear:
		$Timer.start(-1) # iniciando o timer para iniciar a batalha
	pass # Replace with function body.


func _on_Timer_timeout():
	# mani é so pra ficar mais facil/curto a manipulacao
	var mani = manipulation_acess_dd.acess_save(manipulation_acess_dd.path_status_character, "")
	var maniSkills = manipulation_acess_dd.acess_save(manipulation_acess_dd.path_skills, "")



	# entregando dano 
	if manipulation_acess_dd.acess_save(manipulation_acess_dd.path_equip, "")[2]["weapon"] != null and flagNear and life >= 1:
		life -= int(manipulation_acess_dd.acess_save(manipulation_acess_dd.path_equip, "")[2]["damage"])
		mani[0]["life"] -=  attack # recebendo o ataque do ant



	#morte 
	if life <= 0:
		maniSkills[0]["fight"]["xp_current"] += xp
		#$Timer.stop()
		queue_free()


	#atualizando o status do personagem
	manipulation_acess_dd.set_save(manipulation_acess_dd.path_status_character, mani) 
	manipulation_acess_dd.set_save(manipulation_acess_dd.path_skills, maniSkills)
	pass # Replace with function body.


func _on_Area2D_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if body.name == "KinematicBody2D":
		flagNear = true
	pass # Replace with function body.


func _on_Area2D_body_shape_exited(body_rid, body, body_shape_index, local_shape_index):
	if not body: #pra nao crashar se tiver um em cima so outro
		pass
	else:
		if body.name == "KinematicBody2D":
			flagNear = false
			$Timer.stop()
	pass # Replace with function body.
