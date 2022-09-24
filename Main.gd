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

#quando um scorpion morrer ele nos entrga seu x e y para o meet e outros objetos
var position_node_x = 0
var position_node_y = 0
func _on_Main_child_exiting_tree(node):

	if node.is_in_group("animals"):
		if node.is_in_group("Scorpion"):
			# se for o scorpion que morreu o limit do scorpion recebe -1
			limit_scorpion -= 1  #toda vez que morrer um nasce outro
		if node.is_in_group("ant"):
			#se for o ant que morreu limit do ant recebe -1
			limit_ant -= 1
		if node.is_in_group("bug"):
			limit_bug -= 1


		#quando um algo do tipo animals morrer, meet aparece no mesmo lugar x e y
		position_node_x = node.position.x
		position_node_y = node.position.y
		add_child(preload("res://Meet.tscn").instance())

		#parar animacao do personagem quando o scorpion morrer
		if $KinematicBody2D/AnimatedSprite.animation == "up_attack":
			$KinematicBody2D/AnimatedSprite.play("up_idle")
		elif $KinematicBody2D/AnimatedSprite.animation == "down_attack":
			$KinematicBody2D/AnimatedSprite.play("down_idle")
		elif $KinematicBody2D/AnimatedSprite.animation == "side_attack":
			$KinematicBody2D/AnimatedSprite.play("side_idle")

	pass # Replace with function body.




func _on_Main_child_entered_tree(node):
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
		elif node.is_in_group("wood_shield"):
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
