extends Node2D

export (NodePath) var player_character_path
var player_character
var board

func _ready():
	player_character = get_node(player_character_path)

func set_board(b):
	board = b

func get_moves():
	var moves = []
	moves.append({"name":"Walk", "call":funcref(self,"walk"), "is_valid":funcref(self,"walk_is_valid")})
	return moves

func walk_is_valid(gpos):
	return true

func walk(pos):
	return board.move_piece(self, pos)