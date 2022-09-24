extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


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
	if node.is_in_group("item"):
		#necessario mais de um grupo pois as sprites sao de tamanhos diferetentes e precisam
		# de scale diferentes
		if node.is_in_group("sword"):
			node.position.x = $KinematicBody2D.position.x
			node.position.y = $KinematicBody2D.position.y
			node.scale.x = 0.3
			node.scale.y = 0.3
			node.z_index = 2
		if node.is_in_group("iron_sword"):
			node.position.x = $KinematicBody2D.position.x
			node.position.y = $KinematicBody2D.position.y
			node.scale.x = 0.7
			node.scale.y = 0.7
			node.z_index = 2
		elif node.is_in_group("wood_shield"):
			node.position.x = $KinematicBody2D.position.x
			node.position.y = $KinematicBody2D.position.y
			node.z_index = 2
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
	pass # Replace with function body.
