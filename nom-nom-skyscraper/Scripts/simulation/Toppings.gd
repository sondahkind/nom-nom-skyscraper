class BaseTopping:
	var tile_index = -1

	func get_influence():
		return []
	

class ToppingTree extends BaseTopping:
	func _init():
		tile_index = 1 

	func get_influence():
		return [
			[Vector2(0, 0), 2],
			[Vector2(-1, -1), 1],
			[Vector2(1, -1), 1],
			[Vector2(1, 1), 1],
			[Vector2(-1, 1), 1],
		]


class ToppingHut extends BaseTopping:
	func _init():
		tile_index = 2

	func get_influence():
		return [
			[Vector2(0, 0), -2],
			[Vector2(-1, -1), -1],
			[Vector2(1, -1), -1],
			[Vector2(1, 1), -1],
			[Vector2(-1, 1), -1],
		]
