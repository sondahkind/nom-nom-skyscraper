extends TileMap

var select = preload("res://Scenes/Select.tscn").instance()

func _ready():
	add_child(select)

func _unhandled_input(event):
	
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			var clicked_cell = world_to_map(event.position)
			print(clicked_cell)
	elif event is InputEventMouseMotion:
		select.visible = true
		var pos = map_to_world(world_to_map(event.position))
		select.position = pos
