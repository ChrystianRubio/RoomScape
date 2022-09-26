extends Node2D


# Declare member variables here. Examples:
#obtendo um objeto do tipo savegame para acessar o banco de dados
var manipulation_acess_dd = SaveGame.new()
var mani


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#se o personagem jogar algo no chao, esse algo sera filho de cave
	if $KinematicBody2D/Layout.flag_instance_sword:
		add_child(preload("res://Sword.tscn").instance())
		$KinematicBody2D/Layout.flag_instance_sword = false
	
	if $KinematicBody2D/Layout.flag_instance_wood_shield:
		add_child(preload("res://WoodShield.tscn").instance())
		$KinematicBody2D/Layout.flag_instance_wood_shield = false
	
	if $KinematicBody2D/Layout.flag_instance_meet:
		add_child(preload("res://Meet.tscn").instance())
		$KinematicBody2D/Layout.flag_instance_meet = false
	
	
	if $KinematicBody2D/Layout.flag_instance_reforced_wood_shield:
		add_child(preload("res://ReforcedWoodShield.tscn").instance())
		$KinematicBody2D/Layout.flag_instance_reforced_wood_shield = false
	
	if $KinematicBody2D/Layout.flag_instance_simple_axe:
		add_child(preload("res://SimpleAxe.tscn").instance())
		$KinematicBody2D/Layout.flag_instance_simple_axe = false
	
	#item agrupavel
	if $KinematicBody2D/Layout.flag_instance_gold:
		#esse for é para jogar todos as moedas no chao
		for quantify in range(0, $KinematicBody2D/Layout.quantify_gold):
			add_child(preload("res://Gold.tscn").instance())
			$KinematicBody2D/Layout.flag_instance_gold = false
			$KinematicBody2D/Layout.quantify_gold = 0
	
	if $KinematicBody2D/Layout.flag_instance_iron_sword:
		add_child(preload("res://IronSword.tscn").instance())
		$KinematicBody2D/Layout.flag_instance_iron_sword = false
#	pass


func _on_Area2D_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if body:
		if body.name == "KinematicBody2D":
			get_tree().change_scene("res://Main.tscn")
	pass # Replace with function body.

var limit_devourer = 1

func _on_TimerDevourer_timeout():
	if limit_devourer <= 3:
		add_child(preload("res://Devourer.tscn").instance())
		limit_devourer += 1
	pass # Replace with function body.

#quando um scorpion morrer ele nos entrga seu x e y para o meet e outros objetos
var position_node_x = 0
var position_node_y = 0

func _on_CaveOne_child_entered_tree(node):
	#definindo onde o personagem esta para futuras seções
	if node.name == "KinematicBody2D":
		mani = manipulation_acess_dd.acess_save(manipulation_acess_dd.path_status_character, "")
		mani[2]["main"]["current"] = false
		mani[2]["cave_one"]["current"] = true
		mani[2]["store_one"]["current"] = false
		mani[2]["death_city"]["current"] = false
		manipulation_acess_dd.set_save(manipulation_acess_dd.path_status_character, mani)
	if node.is_in_group("item"):
		#necessario mais de um grupo pois as sprites sao de tamanhos diferetentes e precisam
		# de scale diferentes
		if node.is_in_group("sword"):
			node.position.x = $KinematicBody2D.position.x
			node.position.y = $KinematicBody2D.position.y
			node.scale.x = 0.3
			node.scale.y = 0.3
		if node.is_in_group("iron_sword"):
			node.scale.x = 0.7
			node.scale.y = 0.7
			#necessario para posicao correta na hora de jogar fora
			if $KinematicBody2D/Layout.flag_correct_position:
				node.position.x = $KinematicBody2D.position.x
				node.position.y = $KinematicBody2D.position.y
				$KinematicBody2D/Layout.flag_correct_position = false
			else:
				node.position.x = position_node_x
				node.position.y = position_node_y
		if node.is_in_group("axe"):
			node.scale.x = 1
			node.scale.y = 1
			#necessario para posicao correta na hora de jogar fora
			if $KinematicBody2D/Layout.flag_correct_position:
				node.position.x = $KinematicBody2D.position.x
				node.position.y = $KinematicBody2D.position.y
				$KinematicBody2D/Layout.flag_correct_position = false
			else:
				node.position.x = position_node_x
				node.position.y = position_node_y
		elif node.is_in_group("wood_shield"):
			node.position.x = $KinematicBody2D.position.x
			node.position.y = $KinematicBody2D.position.y
			node.scale.x = 1
			node.scale.y = 1
		elif node.is_in_group("reforced_wood_shield"):
			node.position.x = $KinematicBody2D.position.x
			node.position.y = $KinematicBody2D.position.y
			node.scale.x = 1
			node.scale.y = 1
		elif node.is_in_group("gold"):
			node.scale.x = 1
			node.scale.y = 1
			#necessario para posicao correta na hora de jogar fora
			if $KinematicBody2D/Layout.flag_correct_position:
				node.position.x = $KinematicBody2D.position.x
				node.position.y = $KinematicBody2D.position.y
				#$KinematicBody2D/Layout.flag_correct_position = false
			else:
				node.position.x = position_node_x
				node.position.y = position_node_y
		elif node.is_in_group("food"):
			if node.is_in_group("meet"):
				node.scale.x = 1
				node.scale.y = 1
				#necessario para posicao correta na hora de jogar fora
				if $KinematicBody2D/Layout.flag_correct_position:
					node.position.x = $KinematicBody2D.position.x
					node.position.y = $KinematicBody2D.position.y
					$KinematicBody2D/Layout.flag_correct_position = false
				else:
					node.position.x = position_node_x
					node.position.y = position_node_y
					
	pass # Replace with function body.


func _on_CaveOne_child_exiting_tree(node):
	if node.name == "KinematicBody2D":
		mani = manipulation_acess_dd.acess_save(manipulation_acess_dd.path_status_character, "")
		#saindo de store seta o x e y da main, para nao travar no colission da porta que esta antes
		mani[2]["main"]["positionX"] = -2766
		mani[2]["main"]["positionY"] = -512
		manipulation_acess_dd.set_save(manipulation_acess_dd.path_status_character, mani)


	if node.is_in_group("monster"):
		if node.is_in_group("devourer"):
			limit_devourer -= 1

		#quando algo do tipo monster morrer, gold aparece no mesmo lugar x e y
		position_node_x = node.position.x
		position_node_y = node.position.y
		$KinematicBody2D/Layout.flag_correct_position = false #necessario para ir para a posicao correta do bixo
		add_child(preload("res://Gold.tscn").instance())


		#parar animacao do personagem quando algo do tipo monster morrer
		if $KinematicBody2D/AnimatedSprite.animation == "up_attack":
			$KinematicBody2D/AnimatedSprite.play("up_idle")
		elif $KinematicBody2D/AnimatedSprite.animation == "down_attack":
			$KinematicBody2D/AnimatedSprite.play("down_idle")
		elif $KinematicBody2D/AnimatedSprite.animation == "side_attack":
			$KinematicBody2D/AnimatedSprite.play("side_idle")
	pass # Replace with function body.
