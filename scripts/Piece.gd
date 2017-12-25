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
	moves.append({"name":"Walk", "call":funcref(self,"walk"), "get_move_map":funcref(self,"get_walk_map")})
	moves.append({"name":"Attack", "call":funcref(self,"attack"), "get_move_map":funcref(self,"get_attack_map")})
	return moves

func get_walk_map():
	var sgpos = board.get_gpos(self)
	var map = []
	for x in range(board.GRID_WIDTH):
		map.append([])
		for y in range(board.GRID_HEIGHT):
			if board.get_piece(Vector2(x,y)) != null:
				map[x].append(-1)
			else:
				map[x].append(99)
	map[sgpos.x][sgpos.y] = 99
	cost_traverse(map, sgpos.x, sgpos.y, 0)
	for x in range(board.GRID_WIDTH):
		for y in range(board.GRID_HEIGHT):
			map[x][y] = map[x][y] <= 5 and map[x][y] >= 0
			print(map[x][y])
	return map

func get_attack_map():
	var sgpos = board.get_gpos(self)
	var map = []
	for x in range(board.GRID_WIDTH):
		map.append([])
		for y in range(board.GRID_HEIGHT):
			map[x].append(false)
	
	var p
	p = board.get_piece(sgpos + Vector2(1,0))
	if p != null and p.player_character != player_character:
		map[sgpos.x+1][sgpos.y] = true
	p = board.get_piece(sgpos + Vector2(-1,0))
	if p != null and p.player_character != player_character:
		map[sgpos.x-1][sgpos.y] = true
	p = board.get_piece(sgpos + Vector2(0,1))
	if p != null and p.player_character != player_character:
		map[sgpos.x][sgpos.y+1] = true
	p = board.get_piece(sgpos + Vector2(0,-1))
	if p != null and p.player_character != player_character:
		map[sgpos.x][sgpos.y-1] = true
	return map

func cost_traverse(map, x, y, cost):
	if board.is_valid_gpos(Vector2(x,y)):
		if map[x][y] > cost:
			map[x][y] = cost
			cost_traverse(map, x, y+1, cost+1)
			cost_traverse(map, x, y-1, cost+1)
			cost_traverse(map, x+1, y, cost+1)
			cost_traverse(map, x-1, y, cost+1)

func walk(gpos):
	if get_walk_map()[gpos.x][gpos.y]:
		return board.move_piece(self, gpos)
	return false

func attack(gpos):
	if get_attack_map()[gpos.x][gpos.y]:
		board.delete_piece(gpos)
		return true
	return false