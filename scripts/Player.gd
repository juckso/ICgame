extends "res://scripts/Player_Character.gd"

enum STATE{AVAILABLE, TURNING, POPPING, POPUP, TURNING2, TURNED}

var popup
var state
var move_list
var move_id
var move_map

func _ready():
	change_state(STATE.AVAILABLE)
	popup = get_child(0)
	set_process(true)
	set_process_input(true)

func new_turn(turn):
	change_state(STATE.TURNING)

func current_turn():
	if state == STATE.TURNED:
		return true
	else:
		return false

func _process(delta):
	if state == STATE.POPPING:
		popup.popup()
		change_state(STATE.POPUP)

func _input(ev):
	if state == STATE.TURNING:
		if ev.is_action_pressed("ui_click"):
			var board = dungeon_master.get_board()
			var piece = board.get_piece(board.pos_to_gpos(ev.position))
			if piece != null && piece.player_character == self:
				popup.clear()
				popup.set_global_position(ev.position)
				move_list = piece.get_moves()
				for move in move_list:
					popup.add_item(move.name)
				change_state(STATE.POPPING)
	elif state == STATE.TURNING2:
		if ev.is_action_pressed("ui_click"):
			var board = dungeon_master.get_board()
			var gpos = board.pos_to_gpos(ev.position)
			if board.is_valid_gpos(gpos) and move_map[gpos.x][gpos.y]:
				move_list[move_id].call.call_func(gpos)
				change_state(STATE.TURNED)
			else:
				change_state(STATE.TURNING)

func _on_PopupMenu_id_pressed(id):
	move_id = id
	move_map = move_list[move_id].get_move_map.call_func()
	change_state(STATE.TURNING2)

func _draw():
	if state == STATE.TURNING2:
		var board = dungeon_master.get_board()
		for x in range(board.GRID_WIDTH):
			for y in range(board.GRID_HEIGHT):
				if move_map[x][y]:
					draw_rect(Rect2(Vector2(x*board.CELL_WIDTH, y*board.CELL_HEIGHT), Vector2(board.CELL_WIDTH, board.CELL_HEIGHT)), Color(0,0,1,0.5), true)

func _on_PopupMenu_popup_hide():
	if state == STATE.POPUP:
		change_state(STATE.TURNING)

func change_state(s):
	state = s
	update()