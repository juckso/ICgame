extends CanvasItem

var dungeon_master = null

func _ready():
	pass

func new_turn(turn):
	pass

func current_turn():
	return true

func exit_turn():
	pass

func set_dungeon_master(dm):
	dungeon_master = dm

func _draw():
	draw_rect(Rect2(0, 0, 64, 64), Color(0,0,1), true)