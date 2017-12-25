func walk(attacker, gpos, board):
	return board.move_piece(attacker, gpos)

func attack(gpos, board):
	var piece = board.get_piece(gpos)
	piece.recieve_attack(self, {"dp":100})

func get_walk_map(board):
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
	cost_traverse(map, sgpos.x, sgpos.y, 0, 5)
	for x in range(board.GRID_WIDTH):
		for y in range(board.GRID_HEIGHT):
			map[x][y] = map[x][y] < 99 and map[x][y] >= 0
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

func cost_traverse(map, x, y, cost, max_cost):
	if board.is_valid_gpos(Vector2(x,y)):
		if cost <= max_cost and map[x][y] > cost:
			map[x][y] = cost
			cost_traverse(map, x, y+1, cost+1, max_cost)
			cost_traverse(map, x, y-1, cost+1, max_cost)
			cost_traverse(map, x+1, y, cost+1, max_cost)
			cost_traverse(map, x-1, y, cost+1, max_cost)
