extends Node2D

const AttackList = preload("res://scripts/AttackList.gd")
export (NodePath) var player_character_path
var player_character
var board

var hp = 100

func _ready():
	player_character = get_node(player_character_path)

func set_board(b):
	board = b

func get_moves():
	var moves = []
	moves.append({"name":"Walk", "call":funcref(AtackList,"walk"), "get_move_map":funcref(AtackList,"get_walk_map")})
	moves.append({"name":"Attack", "call":funcref(AtackList,"attack"), "get_move_map":funcref(AtackList,"get_attack_map")})
	return moves

func recieve_attack(attacker, attack):
	if attack.dp != null:
		hp -= attack.dp
		if(hp <= 0):
			die()

func die():
	board.remove_piece_ref(board.get_gpos(self))
	for child in get_children():
		remove_child(child)
	remove_and_skip()
