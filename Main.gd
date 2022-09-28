extends Node2D


# Declare member variables here. 

#obtendo um objeto do tipo savegame para acessar o banco de dados
var manipulation_acess_dd = SaveGame.new()
var mani


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	#se o personagem jogar algo no chao, esse algo sera filho de main city
	if $KinematicBody2D/Layout.flag_instance_sword:
		add_child(preload("res://Sword.tscn").instance())
		$KinematicBody2D/Layout.flag_instance_sword = false
	
	if $KinematicBody2D/Layout.flag_instance_wood_shield:
		add_child(preload("res://WoodShield.tscn").instance())
		$KinematicBody2D/Layout.flag_instance_wood_shield = false
	
	if $KinematicBody2D/Layout.flag_instance_meet:
		add_child(preload("res://Meet.tscn").instance())
		$KinematicBody2D/Layout.flag_instance_meet = false
	
	if $KinematicBody2D/Layout.flag_instance_iron_sword:
		add_child(preload("res://IronSword.tscn").instance())
		$KinematicBody2D/Layout.flag_instance_iron_sword = false
	
	if $KinematicBody2D/Layout.flag_instance_reforced_wood_shield:
		add_child(preload("res://ReforcedWoodShield.tscn").instance())
		$KinematicBody2D/Layout.flag_instance_reforced_wood_shield = false
	
	if $KinematicBody2D/Layout.flag_instance_simple_axe:
		add_child(preload("res://SimpleAxe.tscn").instance())
		$KinematicBody2D/Layout.flag_instance_simple_axe = false
	
	if $KinematicBody2D/Layout.flag_instance_wood:
		add_child(preload("res://Wood.tscn").instance())
		$KinematicBody2D/Layout.flag_instance_wood = false
	
	if $KinematicBody2D/Layout.flag_instance_gold:
		#esse for é para jogar todos as moedas no chao
		for quantify in range(0, $KinematicBody2D/Layout.quantify_gold):
			add_child(preload("res://Gold.tscn").instance())
			$KinematicBody2D/Layout.flag_instance_gold = false
			$KinematicBody2D/Layout.quantify_gold = 0
#	pass



var limit_scorpion = 1
var limit_ant = 1
var limit_bug = 1
var limit_simple_tree = 1

func _on_TimerScorpion_timeout():
	if limit_scorpion <= 5:
		add_child(preload("res://Scorpion.tscn").instance())
		limit_scorpion += 1


func _on_TimerAnt_timeout():
	if limit_ant <= 5:
		add_child(preload("res://Ant.tscn").instance())
		limit_ant += 1
	pass # Replace with function body.


func _on_TimerBug_timeout():
	if limit_bug <= 5:
		add_child(preload("res://Bug.tscn").instance())
		limit_bug += 1
	pass # Replace with function body.


func _on_TimerSimpleTree_timeout():
	if limit_simple_tree <= 5:
		add_child(preload("res://SimpleTree.tscn").instance())
		limit_simple_tree += 1
	pass # Replace with function body.


#quando um algo morrer ele nos entrga seu x e y para o meet e outros objetos
var position_node_x = 0
var position_node_y = 0
func _on_Main_child_exiting_tree(node):

	#pegando a posicao x e y do personagem
	if node.name == "KinematicBody2D":
		mani = manipulation_acess_dd.acess_save(manipulation_acess_dd.path_status_character, "")
		mani[2]["main"]["positionX"] = $KinematicBody2D.position.x 
		mani[2]["main"]["positionY"] = $KinematicBody2D.position.y 
		manipulation_acess_dd.set_save(manipulation_acess_dd.path_status_character, mani)
	if node.is_in_group("tree"):
		#quando um algo do tipo tree morrer, wood aparece no mesmo lugar x e y
		position_node_x = node.position.x
		position_node_y = node.position.y

		if node.is_in_group("simple_tree"):
			limit_simple_tree -= 1

		#porcentagem de drop
		var percentual_simple_tree_drop_wood = rand_range(0, 100)
		if percentual_simple_tree_drop_wood < 20:
			add_child(preload("res://Wood.tscn").instance())
	if node.is_in_group("animals"):
		#quando um algo do tipo animals morrer, meet aparece no mesmo lugar x e y
		position_node_x = node.position.x
		position_node_y = node.position.y
		if node.is_in_group("Scorpion"):
			# se for o scorpion que morreu o limit do scorpion recebe -1
			limit_scorpion -= 1  #toda vez que morrer um nasce outro
			#porcentagem de drop
			var percentual_scorpion_drop_meat = rand_range(0, 100)
			if percentual_scorpion_drop_meat < 40:
				add_child(preload("res://Meet.tscn").instance())
		if node.is_in_group("ant"):
			#se for o ant que morreu limit do ant recebe -1
			limit_ant -= 1
			var percentual_ant_drop_meat = rand_range(0, 100)
			if percentual_ant_drop_meat < 25:
				add_child(preload("res://Meet.tscn").instance())
		if node.is_in_group("bug"):
			limit_bug -= 1
			var percentual_bug_drop_meat = rand_range(0, 100)
			if percentual_bug_drop_meat < 20:
				add_child(preload("res://Meet.tscn").instance())

		#quando um algo do tipo animals morrer, meet aparece no mesmo lugar x e y
		#position_node_x = node.position.x
		#position_node_y = node.position.y
		#add_child(preload("res://Meet.tscn").instance())

	#parar animacao do personagem algo morrer
	if $KinematicBody2D/AnimatedSprite.animation == "up_attack":
		$KinematicBody2D/AnimatedSprite.play("up_idle")
	elif $KinematicBody2D/AnimatedSprite.animation == "down_attack":
		$KinematicBody2D/AnimatedSprite.play("down_idle")
	elif $KinematicBody2D/AnimatedSprite.animation == "side_attack":
		$KinematicBody2D/AnimatedSprite.play("side_idle")

	pass # Replace with function body.




func _on_Main_child_entered_tree(node):
	#definindo onde o personagem esta para futuras seções
	if node.name == "KinematicBody2D":
		mani = manipulation_acess_dd.acess_save(manipulation_acess_dd.path_status_character, "")
		mani[2]["main"]["current"] = true
		mani[2]["cave_one"]["current"] = false
		mani[2]["store_one"]["current"] = false
		mani[2]["death_city"]["current"] = false
		$KinematicBody2D.position.x = mani[2]["main"]["positionX"]
		$KinematicBody2D.position.y = mani[2]["main"]["positionY"]
		manipulation_acess_dd.set_save(manipulation_acess_dd.path_status_character, mani)

	if node.is_in_group("item"):
		#necessario mais de um grupo pois as sprites sao de tamanhos diferetentes e precisam
		# de scale diferentes
		if node.is_in_group("wood"):
			node.scale.x = 0.8
			node.scale.y = 0.8
			#necessario para posicao correta na hora de jogar fora

			if $KinematicBody2D/Layout.flag_correct_position:
				node.position.x = $KinematicBody2D.position.x
				node.position.y = $KinematicBody2D.position.y
				$KinematicBody2D/Layout.flag_correct_position = false
			else:
				node.position.x = position_node_x
				node.position.y = position_node_y
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

			node.position.x = $KinematicBody2D.position.x
			node.position.y = $KinematicBody2D.position.y
			node.scale.x = 1
			node.scale.y = 1
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
					


func _on_ColiisonCaveOne_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if body:
		if body.name == "KinematicBody2D":
			get_tree().change_scene("res://CaveOne.tscn")
	pass # Replace with function body.


func _on_ColliionStoreOne_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if body:
		if body.name == "KinematicBody2D":
			get_tree().change_scene("res://StoreOne.tscn")
	pass # Replace with function body.

