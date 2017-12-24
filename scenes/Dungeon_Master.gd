extends Node2D

const Grid = preload("res://scripts/Grid.gd")
const Player_Character = preload("res://scripts/Player_Character.gd")

var board
var players

var turn
var curr_player_idx

func _ready():
	board = null
	players = []
	for child in get_children():
		if child is Grid and board == null:
			board = child
		elif child is Player_Character:
			child.set_dungeon_master(self)
			players.append(child)
	
	turn = 0
	curr_player_idx = 0
	players[curr_player_idx].new_turn(turn)
	set_process(true)

func _process(delta):
	if players[curr_player_idx].current_turn():
		players[curr_player_idx].exit_turn()
		curr_player_idx = (curr_player_idx + 1) % players.size()
		if(curr_player_idx == 0):
			turn += 1
		players[curr_player_idx].new_turn(turn)

func get_board():
	return board

