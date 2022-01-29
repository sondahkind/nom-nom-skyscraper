const SIZE = 12
const field = preload("res://Scripts/simulation/Field.gd")


class Map:
	var fields = {}

	func _init():
		for x in range(SIZE):
			for y in range(SIZE):
				self.fields[_key(x, y)] = field.Field.new()

	func get_tile(x, y):
		return self.fields[_key(x, y)]
	
	func _key(x: int, y: int) -> String:
		return String(x) + "." + String(y)


