extends TileMap

var select_texture = preload("res://Scenes/Select.tscn")
var select
var select_pos

var game_logic

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
	select = []
	select_pos = null


func _on_map_refresh():
	print("map refresh - Basemap")
	for field in Global.sim.current_map.fields.values():
		set_cell(field.pos[0], field.pos[1], field.base_type())
	

func _unhandled_input(event):
	if game_logic.currentPhase != game_logic.PLAY_CARD_PHASE:
		if _showSelect:
			_clean_preview()
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
		var current_card = game_logic.get_card_manager().current_card
		var pos = world_to_map(get_global_mouse_position())
		_show_preview(pos, current_card.card_topping)

func _clean_preview():
	for child in select:
		remove_child(child)
	select = []

func _show_preview(pos, card_topping):
	if _showSelect and select_pos == pos:
		return

	_clean_preview()
	_showSelect = true
	
	for influence in card_topping.get_influence():
		var preview_pos = pos + influence[0]
		var field = Global.sim.current_map.get_tile(preview_pos.x, preview_pos.y)
		if field == null:
			continue
		var preview = select_texture.instance()
		# var preview_text = Label.new()
		# preview_text.text = String(abs(influence[1]))
		add_child(preview)
		# add_child(preview_text)
		select.append(preview)
		# select.append(preview_text)
		preview.position = self.to_global(map_to_world(preview_pos))
		# preview_text.position = self.to_global(map_to_world(preview_pos))

	var current_card = game_logic.get_card_manager().current_card

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

