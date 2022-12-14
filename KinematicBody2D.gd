extends KinematicBody2D


# Declare member variables here. Examples:


#obtendo um objeto do tipo savegame para acessar o banco de dados
var manipulation_acess_dd = SaveGame.new()
var mani
# Called when the node enters the scene tree for the first time.
#func _ready():
#	pass # Replace with function body.

export (int) var speed = 200
var max_life = 10

var velocity = Vector2()

#movimentacao persoangem
func get_input():
	velocity = Vector2()

	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
		$AnimatedSprite.flip_h = true
		$AnimatedSprite.play("side_walk")
	elif Input.is_action_just_released("ui_right"):
		$AnimatedSprite.play("side_idle")


	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
		$AnimatedSprite.flip_h = false
		$AnimatedSprite.play("side_walk")

	elif Input.is_action_just_released("ui_left"):
		$AnimatedSprite.play("side_idle")


	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
		$AnimatedSprite.play("down_walk")
	elif Input.is_action_just_released("ui_down"):
		$AnimatedSprite.play("down_idle")


	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
		$AnimatedSprite.play("up_walk")
	elif Input.is_action_just_released("ui_up"):
		$AnimatedSprite.play("up_idle")


	if Input.is_action_pressed('ui_space'):
		if $AnimatedSprite.animation == "up_idle":
			$AnimatedSprite.play("up_attack")
		elif $AnimatedSprite.animation == "down_idle":
			$AnimatedSprite.play("down_attack")
		elif $AnimatedSprite.animation == "side_idle":
			$AnimatedSprite.play("side_attack")




	velocity = velocity.normalized() * speed

func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	#pegando posicao x  e y toda hora pq o android ao reconehce o exited corretamente(se for sair do jogo)
	mani = manipulation_acess_dd.acess_save(manipulation_acess_dd.path_status_character, "")
	mani[2]["main"]["positionX"] = position.x 
	mani[2]["main"]["positionY"] = position.y 
	manipulation_acess_dd.set_save(manipulation_acess_dd.path_status_character, mani)
	
	#morte do pesonagem
	if manipulation_acess_dd.acess_save(manipulation_acess_dd.path_status_character, "")[0]["life"] <= 0:
		manipulation_acess_dd.set_save(manipulation_acess_dd.path_status_character, manipulation_acess_dd.default_value_status)
		get_tree().change_scene("res://Death_City.tscn")



	#mostrando um  progress bar com a vida do personagem
	$TextureProgress.value =  manipulation_acess_dd.acess_save(manipulation_acess_dd.path_status_character, "")[0]["life"]
	$TextureProgress.max_value = manipulation_acess_dd.acess_save(manipulation_acess_dd.path_status_character, "")[1]["max_life"]
	

#	pass


# a cada x tempo o personagem ganha x vida e mostra no log
func _on_HealthLife_timeout():
	var mani = manipulation_acess_dd.acess_save(manipulation_acess_dd.path_status_character, "")
	if mani[0]["life"] < manipulation_acess_dd.acess_save(manipulation_acess_dd.path_status_character, "")[1]["max_life"]:
		mani[0]["life"] += 1
		$Layout/gameEventsLayout/EventsLog.text += manipulation_acess_dd.value_game_events_manipulation["healthLife"] + \
		" => " + str(manipulation_acess_dd.acess_save(manipulation_acess_dd.path_status_character, "")[0]["life"] + 1) + "\n"
		

	manipulation_acess_dd.set_save(manipulation_acess_dd.path_status_character, mani)
	pass # Replace with function body.
