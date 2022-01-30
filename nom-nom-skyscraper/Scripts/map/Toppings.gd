extends TileMap

var dragging = false
# var cam: Camera2D
var game_logic
var mouse_start_pos

func _ready():
	game_logic = get_node("/root/Node2D/GameLogic")
	# cam = get_node("/root/Node2D/Map/Camera2D")
	Global.bus.connect("map_refresh", self, "_on_map_refresh")


func _on_map_refresh():
	print("map refresh - toppings!")
	for field in Global.sim.current_map.fields.values():
		set_cell(field.pos[0], field.pos[1], field.duality_topping.tile_index)

	


