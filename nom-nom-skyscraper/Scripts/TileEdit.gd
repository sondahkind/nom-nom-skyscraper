extends TileMap

var select = preload("res://Scenes/Select.tscn").instance()

const WILDERNESS = 0
const INDUSTRY = 1
const DEFAULT = 2
var field_manager
var map_size = 15

func _ready():
	add_child(select)
	field_manager = get_node("/root/Node2D/FieldManager")
	# create list of all cells that are in use
	for x in range(-map_size, map_size):
		for y in range(-map_size, map_size):
			if self.get_cell(x, y) == DEFAULT:
				field_manager.create_field(Vector2(x, y))

func set_tiles(pos, type):
	self.set_cell(pos.x+1, pos.y, type)
	self.set_cell(pos.x-1, pos.y, type)
	self.set_cell(pos.x, pos.y+1, type)
	self.set_cell(pos.x, pos.y-1, type)
	
	self.set_cell(pos.x+1, pos.y+1, type)
	self.set_cell(pos.x-1, pos.y-1, type)
	self.set_cell(pos.x-1, pos.y+1, type)
	self.set_cell(pos.x+1, pos.y-1, type)

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			var clicked_cell = world_to_map(event.position)
			set_tiles(clicked_cell, INDUSTRY)
	elif event is InputEventMouseMotion:
		select.visible = true
		var pos = map_to_world(world_to_map(event.position))
		select.position = pos
