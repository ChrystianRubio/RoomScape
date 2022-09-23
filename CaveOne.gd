extends Node2D


# Declare member variables here. Examples:



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
	if node.is_in_group("item"):
		#necessario mais de um grupo pois as sprites sao de tamanhos diferetentes e precisam
		# de scale diferentes
		if node.is_in_group("sword"):
			node.position.x = $KinematicBody2D.position.x
			node.position.y = $KinematicBody2D.position.y
			node.scale.x = 0.3
			node.scale.y = 0.3
		elif node.is_in_group("wood_shield"):
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
					
	pass # Replace with function body.


func _on_CaveOne_child_exiting_tree(node):
	if node.is_in_group("monster"):
		if node.is_in_group("devourer"):
			limit_devourer -= 1


		#parar animacao do personagem quando algo do tipo monster morrer
		if $KinematicBody2D/AnimatedSprite.animation == "up_attack":
			$KinematicBody2D/AnimatedSprite.play("up_idle")
		elif $KinematicBody2D/AnimatedSprite.animation == "down_attack":
			$KinematicBody2D/AnimatedSprite.play("down_idle")
		elif $KinematicBody2D/AnimatedSprite.animation == "side_attack":
			$KinematicBody2D/AnimatedSprite.play("side_idle")
	pass # Replace with function body.
