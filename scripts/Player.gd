extends "res://scripts/Player_Character.gd"

enum STATE{AVAILABLE, TURNING, POPPING, POPUP, TURNING2, TURNED}

var label
var popup
var state
var move_list

func _ready():
	label = get_child(0).get_child(0).get_child(0)
	state = STATE.AVAILABLE
	popup = get_child(1)
	set_process(true)
	set_process_input(true)

func new_turn(turn):
	label.text = "TURN: " + String(turn)
	state = STATE.TURNING

func current_turn():
	if state == STATE.TURNED:
		return true
	else:
		return false

func _process(delta):
	if state == STATE.POPPING:
		popup.popup()
		state = STATE.POPUP

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
				state = STATE.POPPING

func _on_PopupMenu_id_pressed(id):
	print(move_list[id].is_valid.call_func(Vector2()))
	state = STATE.TURNING2
	update()
	
func _draw():
	if state == STATE.TURNING2:
		var board = dungeon_master.get_board()
		for x in range(board.GRID_WIDTH):
			for y in range(board.GRID_HEIGHT):
				draw_rect(Rect2(Vector2(x*board.CELL_WIDTH, y*board.CELL_HEIGHT), Vector2(board.CELL_WIDTH, board.CELL_HEIGHT)), Color(0,0,1), true)