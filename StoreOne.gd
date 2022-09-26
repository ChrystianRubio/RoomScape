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
	#se o personagem jogar algo no chao, esse algo sera filho da cidade
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


# ir embora
func _on_Area2D_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if body:
		if body.name == "KinematicBody2D":
			get_tree().change_scene("res://Main.tscn")
	pass # Replace with function body.



func _on_Estavan_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if body:
		if body.name == "KinematicBody2D":
			$KinematicBody2D/Layout/optionsLayout/ItemListStore.visible = true
	pass # Replace with function body.


func _on_Estavan_body_shape_exited(body_rid, body, body_shape_index, local_shape_index):
	if body:
		if body.name == "KinematicBody2D":
			$KinematicBody2D/Layout/optionsLayout/ItemListStore.visible = false
	pass # Replace with function body.

#quando algo morrer ele nos entrga seu x e y para o meet e outros objetos
var position_node_x = 0
var position_node_y = 0

func _on_StoreOne_child_entered_tree(node):
		#definindo onde o personagem esta para futuras seções
	if node.name == "KinematicBody2D":
		mani = manipulation_acess_dd.acess_save(manipulation_acess_dd.path_status_character, "")
		mani[2]["main"]["current"] = false
		mani[2]["cave_one"]["current"] = false
		mani[2]["store_one"]["current"] = true
		mani[2]["death_city"]["current"] = false
		manipulation_acess_dd.set_save(manipulation_acess_dd.path_status_character, mani)
	
	if node.is_in_group("item"):
		#necessario mais de um grupo pois as sprites sao de tamanhos diferetentes e precisam
		# de scale diferentes
		if node.is_in_group("sword"):
			node.position.x = 518
			node.position.y = 184
			node.scale.x = 0.3
			node.scale.y = 0.3
			node.z_index = 2
		if node.is_in_group("iron_sword"):
			node.position.x = $KinematicBody2D.position.x
			node.position.y = $KinematicBody2D.position.y
			node.scale.x = 0.7
			node.scale.y = 0.7
			node.z_index = 2
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
			node.position.x = 729
			node.position.y = 185
			node.z_index = 2
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
			node.z_index = 2
			node.scale.x = 1
			node.scale.y = 1

		elif node.is_in_group("food"):
			if node.is_in_group("meet"):
				node.scale.x = 1
				node.scale.y = 1
				node.z_index = 2
				#necessario para posicao correta na hora de jogar fora
				if $KinematicBody2D/Layout.flag_correct_position:
					node.position.x = $KinematicBody2D.position.x
					node.position.y = $KinematicBody2D.position.y
					$KinematicBody2D/Layout.flag_correct_position = false
				else:
					node.position.x = position_node_x
					node.position.y = position_node_y
					
	pass # Replace with function body.


func _on_StoreOne_child_exiting_tree(node):
	if node.name == "KinematicBody2D":
		mani = manipulation_acess_dd.acess_save(manipulation_acess_dd.path_status_character, "")
		#setando o x e y do store se caso o jogador sair nessa cena
		#mani[2]["store_one"]["positionX"] = $KinematicBody2D.position.x
		#mani[2]["store_one"]["positionY"] = $KinematicBody2D.position.y
		#saindo de store seta o x e y da main, para nao travar no colission da porta que estava antes
		mani[2]["main"]["positionX"] = -701
		mani[2]["main"]["positionY"] = -334
		manipulation_acess_dd.set_save(manipulation_acess_dd.path_status_character, mani)
	pass # Replace with function body.
