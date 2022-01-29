extends Node

var fields = []

const field_preload = preload('Field.gd')

func create_field(pos):
	var field = field_preload.Field.new()
	field.pos = pos
	fields.append(field)

func get_field(x, y):
	for field in fields:
		if field.pos.x == x and field.pos.y == y:
			return field
	return null

func get_overall_values():
	var duality = 0
	for field in fields:
		duality += field.duality
	return duality
