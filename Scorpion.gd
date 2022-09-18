extends Node2D


# Declare member variables here. Examples:
#obtendo um objeto do tipo savegame para acessar o banco de dados
var manipulation_acess_dd = SaveGame.new()


var attack = 1
var life = 3


# Called when the node enters the scene tree for the first time.
func _ready():
	#$AnimatedSprite.play("idle")
	$KinematicBody2D/AnimatedSprite.play("idle")
	position.x = rand_range(-2404, -2748)
	position.y = rand_range(6, 227)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_TouchScreenButton_pressed():
	#enquanto nao tiver equipado algo na weapon nao comeca o timer
	if manipulation_acess_dd.acess_save(manipulation_acess_dd.path_equip, "")[2]["weapon"] != null:
		$Timer.start(-1) # iniciando o timer para iniciar a batalha


func _on_Timer_timeout():
	# mani é so pra ficar mais facil/curto a manipulacao
	var mani = manipulation_acess_dd.acess_save(manipulation_acess_dd.path_status_character, "")
	var maniSkills = manipulation_acess_dd.acess_save(manipulation_acess_dd.path_skills, "")

	mani[0]["life"] -=  attack # recebendo o ataque do scorpion


	# entregando dano ao scorpion
	if manipulation_acess_dd.acess_save(manipulation_acess_dd.path_equip, "")[2]["weapon"] != null:
		life -= int(manipulation_acess_dd.acess_save(manipulation_acess_dd.path_equip, "")[2]["weapon"]) 
		maniSkills[0]["attack"] += 0.1

	#atualizando o status do personagem
	manipulation_acess_dd.set_save(manipulation_acess_dd.path_status_character, mani) 
	manipulation_acess_dd.set_save(manipulation_acess_dd.path_skills, maniSkills)
	#morte scorpion
	if life <= 0:
		queue_free()

	pass # Replace with function body.
