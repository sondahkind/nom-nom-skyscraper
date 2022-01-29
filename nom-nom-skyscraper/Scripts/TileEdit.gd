extends TileMap

var select = preload("res://Scenes/Select.tscn").instance()
var sprite


var game_logic
var field_manager

const INDUSTRY = 0
const WILDERNESS = 1
const PRIMAL = 2

var map_size = 15

var _showSelect = false

func _ready():
	game_logic = get_node("/root/Node2D/GameLogic")
	# create list of all cells that are in use
	for x in range(-map_size, map_size):
		for y in range(-map_size, map_size):
			if self.get_cell(x, y) >= 0:
				Global.sim.used_tile(x, y)
	
	Global.sim.used_tiles_marked()
	Global.bus.connect("map_refresh", self, "_on_map_refresh")


func _on_map_refresh():
	print("map refresh - Basemap")
	for field in Global.sim.current_map.fields.values():
		set_cell(field.pos[0], field.pos[1], field.base_type())
	

func _unhandled_input(event):
	if game_logic.currentPhase != game_logic.PLAY_CARD_PHASE:
		if _showSelect:
			remove_child(select)
			_showSelect = false
		return
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			var clicked_cell = self.to_global(world_to_map(get_global_mouse_position()))
			var current_card = game_logic.get_card_manager().current_card
			var card_type = current_card.card_topping
			var tile = Global.sim.current_map.get_tile(clicked_cell.x, clicked_cell.y)
			if not tile:
				# ignore if the player clicks outside the map
				return
			tile.duality_topping = card_type
			game_logic.next_phase()
	elif event is InputEventMouseMotion:
		if not _showSelect:
			add_child(select)
			_showSelect = true
		var pos = self.to_global(map_to_world(world_to_map(get_global_mouse_position())))
		select.position = pos


# func set_type(x, y, type):
# 	var field = field_manager.get_field(x, y)
# 	if not field:
# 		return
# 	if type == INDUSTRY:
# 		field.add_industry(1)
# 	elif type == WILDERNESS:
# 		field.add_wilderness(1)
# 	self.set_cell(x, y, type)

# func set_tiles(pos, type):
# 	set_type(pos.x, pos.y, -1)
# 	print("M update: ", pos[0], ",", pos[1])
# 	set_type(pos.x+1, pos.y, type)
# 	set_type(pos.x-1, pos.y, type)
# 	set_type(pos.x, pos.y+1, type)
# 	set_type(pos.x, pos.y-1, type)
	
# 	set_type(pos.x+1, pos.y+1, type)
# 	set_type(pos.x+1, pos.y-1, type)
# 	set_type(pos.x-1, pos.y+1, type)
# 	set_type(pos.x-1, pos.y-1, type)

