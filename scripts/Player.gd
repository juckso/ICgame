extends KinematicBody2D

var screensize
export (int) var speed = 250

func _ready():
	screensize = get_viewport_rect().size
	set_process(true)

func _process(delta):
	var posD = Vector2()
	if(Input.is_action_pressed("ui_up")):
		posD.y -= 1
	if(Input.is_action_pressed("ui_right")):
		posD.x += 1
	if(Input.is_action_pressed("ui_down")):
		posD.y += 1
	if(Input.is_action_pressed("ui_left")):
		posD.x -= 1
	#position += posD.normalized() * speed * delta
	
	#position.x = clamp(position.x, 0, screensize.x)
	#position.y = clamp(position.y, 0, screensize.y)
	
	move_and_slide(posD.normalized() * speed)