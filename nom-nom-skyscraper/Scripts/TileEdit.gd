extends TileMap

var select = preload("res://Scenes/Select.tscn").instance()

var game_logic
var field_manager

const WILDERNESS = 1
const INDUSTRY = 2
const PRIMAL = 0

var map_size = 15

var _showSelect = false

func _ready():
	game_logic = get_node("/root/Node2D/GameLogic")
	field_manager = get_node("/root/Node2D/FieldManager")
	# create list of all cells that are in use
	for x in range(-map_size, map_size):
		for y in range(-map_size, map_size):
			if self.get_cell(x, y) == PRIMAL:
				field_manager.create_field(Vector2(x, y))

func _unhandled_input(event):
	if game_logic.currentPhase != game_logic.PLAY_CARD_PHASE:
		if _showSelect:
			remove_child(select)
			_showSelect = false
		return
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			var clicked_cell = world_to_map(event.position)
			set_tiles(clicked_cell, INDUSTRY)
			game_logic.next_phase()
	elif event is InputEventMouseMotion:
		if not _showSelect:
			add_child(select)
			_showSelect = true
		var pos = map_to_world(world_to_map(event.position))
		select.position = pos

func set_type(x, y, type):
	var field = field_manager.get_field(x, y)
	if not field:
		return
	if type == INDUSTRY:
		field.add_industry(1)
	elif type == WILDERNESS:
		field.add_wilderness(1)
	self.set_cell(x, y, type)

func set_tiles(pos, type):
	set_type(pos.x+1, pos.y, type)
	set_type(pos.x-1, pos.y, type)
	set_type(pos.x, pos.y+1, type)
	set_type(pos.x, pos.y-1, type)
	
	set_type(pos.x+1, pos.y+1, type)
	set_type(pos.x+1, pos.y-1, type)
	set_type(pos.x-1, pos.y+1, type)
	set_type(pos.x-1, pos.y-1, type)

