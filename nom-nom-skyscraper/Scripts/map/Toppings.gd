extends TileMap

var dragging = false
var cam: Camera2D
var game_logic
var mouse_start_pos

func _ready():
	game_logic = get_node("/root/Node2D/GameLogic")
	cam = get_node("/root/Node2D/Map/Camera2D")
	game_logic.connect("map_refresh", self, "_on_map_refresh")


func _on_map_refresh():
	print("map refresh - toppings!")

func _unhandled_input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_RIGHT:
		dragging = event.is_pressed()
		if dragging:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			mouse_start_pos = event.position
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			get_viewport().warp_mouse(mouse_start_pos)
	# Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE

	elif event is InputEventMouseMotion:
		if not dragging:
			return
		
		cam.position = (mouse_start_pos - event.position)
		cam.set_position(cam.position + event.relative)
		print(cam.position + event.relative)
		
		
	

