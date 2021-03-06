extends Node2D

export (int) var GRID_WIDTH = 10
export (int) var GRID_HEIGHT = 10
export (int) var CELL_WIDTH = 32
export (int) var CELL_HEIGHT = 32

const Piece = preload("res://scripts/Piece.gd")

var grid

func _ready():
	grid = []
	for x in range(GRID_WIDTH):
		grid.append([])
		for y in range(GRID_HEIGHT):
			grid[x].append(null)
	set_process(true)
			
	for child in get_children():
		if child is Piece:
			var child_pos = child.position
			child_pos.x = floor(child_pos.x/CELL_WIDTH)
			child_pos.y = floor(child_pos.y/CELL_HEIGHT)
			if child_pos.x < GRID_WIDTH and child_pos.y < GRID_HEIGHT and grid[child_pos.x][child_pos.y] == null:
				child.position = Vector2(child_pos.x * CELL_WIDTH, child_pos.y * CELL_HEIGHT)
				child.set_board(self)
				grid[child_pos.x][child_pos.y] = child

func pos_to_gpos(pos):
	var gpos = pos
	gpos.x = floor(gpos.x/CELL_WIDTH)
	gpos.y = floor(gpos.y/CELL_HEIGHT)
	return gpos
	
func is_valid_gpos(gpos):
	return gpos.x >= 0 and gpos.y >= 0 and gpos.x < GRID_WIDTH and gpos.y < GRID_HEIGHT

func get_piece(gpos):
	return grid[gpos.x][gpos.y]

func get_gpos(piece):
	for x in range(GRID_WIDTH):
		for y in range(GRID_HEIGHT):
			if grid[x][y] == piece:
				return Vector2(x, y)
	return null

func move_piece(piece, gpos):
	for x in range(GRID_WIDTH):
		for y in range(GRID_HEIGHT):
			if grid[x][y] == piece:
				grid[gpos.x][gpos.y] = piece
				grid[x][y] = null
				return true
	return false

func remove_piece_ref(gpos):
	grid[gpos.x][gpos.y] = null

func _process(delta):
	for x in range(GRID_WIDTH):
		for y in range(GRID_HEIGHT):
			if grid[x][y] != null:
				grid[x][y].position = Vector2(x * CELL_WIDTH, y * CELL_HEIGHT)
				#print(grid[x][y].position)