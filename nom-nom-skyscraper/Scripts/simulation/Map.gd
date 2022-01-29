const SIZE = 12
const field = preload("res://Scripts/simulation/Field.gd")


class Map:
	var fields = {}

	func _init(tiles):
		for tile in tiles:
			var f = field.Field.new()
			f.pos = tile
			self.fields[_key(tile.x, tile.y)] = f
		# for line in range(9):
		# 	for right in range(7):
		# 		var x = (right + 1)
		# 		x += line % 2
		# 		var y = (right + 1) * -1 + line

		# 		var f = field.Field.new()
		# 		f.pos = Vector2(x, y)
		# 		self.fields[_key(x, y)] = f

	func get_tile(x, y):
		return self.fields[_key(x, y)]
	
	func _key(x: int, y: int) -> String:
		return String(x) + "." + String(y)


