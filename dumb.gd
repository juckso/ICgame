extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _draw():
	draw_rect(Rect2(0, 0, 64, 64), Color(0,0,1), true)
	pass