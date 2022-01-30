class BaseTopping:
	var tile_index = -1

	func get_influence():
		return []
	

class ToppingTree extends BaseTopping:
	func _init():
		tile_index = 5

	func get_influence():
		return [
			[Vector2(0, 0), 3],
			[Vector2(0, 1), 1],
			[Vector2(1, 0), 1],
			[Vector2(-1, 0), 1],
			[Vector2(0, -1), 1],
			[Vector2(-1, -1), 1],
			[Vector2(1, -1), 1],
			[Vector2(1, 1), 1],
			[Vector2(-1, 1), 1],
		]

class ToppingHill extends BaseTopping:
	func _init():
		tile_index = 6

	func get_influence():
		return [
			[Vector2(0, 0), 2],
			[Vector2(0, 1), 2],
			[Vector2(0, 2), 2],
			[Vector2(0, 3), 2],
			[Vector2(0, 4), 2],
			[Vector2(0, -1), 2],
			[Vector2(0, -2), 2],
			[Vector2(0, -3), 2],
			[Vector2(0, -4), 2],
			[Vector2(1, 0), 2],
			[Vector2(2, 0), 2],
			[Vector2(3, 0), 2],
			[Vector2(4, 0), 2],
			[Vector2(-1, 0), 2],
			[Vector2(-2, 0), 2],
			[Vector2(-3, 0), 2],
			[Vector2(-4, 0), 2],
		]

class ToppingBigTree extends BaseTopping:
	func _init():
		tile_index = 7

	func get_influence():
		return [
			[Vector2(0, 0), 3],
			[Vector2(0, 1), 1],
			[Vector2(1, 0), 1],
			[Vector2(-1, 0), 1],
			[Vector2(0, -1), 1],
			[Vector2(-1, -1), 1],
			[Vector2(1, -1), 1],
			[Vector2(1, 1), 1],
			[Vector2(-1, 1), 1],
			[Vector2(0, 2), 1],
			[Vector2(2, 0), 1],
			[Vector2(-2, 0), 1],
			[Vector2(0, -2), 1],
			[Vector2(-2, -2), 1],
			[Vector2(2, -2), 1],
			[Vector2(2, 2), 1],
			[Vector2(-2, 2), 1],			
			[Vector2(1, 2), 1],
			[Vector2(2, 1), 1],
			[Vector2(-2, 1), 1],
			[Vector2(1, -2), 1],
			[Vector2(-1, 2), 1],
			[Vector2(2, -1), 1],
			[Vector2(-2, -1), 1],
			[Vector2(-1, -2), 1],
		]

class ToppingSwamp extends BaseTopping:
	func _init():
		tile_index = 8

	func get_influence():
		return [
			[Vector2(0, 0), 5],
			[Vector2(0, 1), 5],
			[Vector2(1, 0), 5],
			[Vector2(-1, 0), 5],
			[Vector2(0, -1), 5],
			[Vector2(-1, -1), 5],
			[Vector2(1, -1), 5],
			[Vector2(1, 1), 5],
			[Vector2(-1, 1), 5],
		]

class ToppingNomNomPlant extends BaseTopping:
	func _init():
		tile_index = 9

	func get_influence():
		return [
			[Vector2(0, 0), 5],
			[Vector2(0, 1), 3],
			[Vector2(1, 0), 3],
			[Vector2(-1, 0), 3],
			[Vector2(0, -1), 3],
			[Vector2(-1, -1), 3],
			[Vector2(1, -1), 3],
			[Vector2(1, 1), 3],
			[Vector2(-1, 1), 3],
			[Vector2(0, 2), 2],
			[Vector2(2, 0), 2],
			[Vector2(-2, 0), 2],
			[Vector2(0, -2), 2],
			[Vector2(-2, -2), 2],
			[Vector2(2, -2), 2],
			[Vector2(2, 2), 2],
			[Vector2(-2, 2), 2],			
			[Vector2(1, 2), 2],
			[Vector2(2, 1), 2],
			[Vector2(-2, 1), 2],
			[Vector2(1, -2), 2],
			[Vector2(-1, 2), 2],
			[Vector2(2, -1), 2],
			[Vector2(-2, -1), 2],
			[Vector2(-1, -2), 2],
		]

class ToppingHut extends BaseTopping:
	func _init():
		tile_index = 0

	func get_influence():
		return [
			[Vector2(0, 0), -3],
			[Vector2(0, 1), -1],
			[Vector2(1, 0), -1],
			[Vector2(-1, 0), -1],
			[Vector2(0, -1), -1],
			[Vector2(-1, -1), -1],
			[Vector2(1, -1), -1],
			[Vector2(1, 1), -1],
			[Vector2(-1, 1), -1],
		]

class ToppingShop extends BaseTopping:
	func _init():	
		tile_index = 1

	func get_influence():
		return [
			[Vector2(0, 0), -2],
			[Vector2(0, 1), -2],
			[Vector2(0, 2), -2],
			[Vector2(0, 3), -2],
			[Vector2(0, 4), -2],
			[Vector2(0, -1), -2],
			[Vector2(0, -2), -2],
			[Vector2(0, -3), -2],
			[Vector2(0, -4), -2],
			[Vector2(1, 0), -2],
			[Vector2(2, 0), -2],
			[Vector2(3, 0), -2],
			[Vector2(4, 0), -2],
			[Vector2(-1, 0), -2],
			[Vector2(-2, 0), -2],
			[Vector2(-3, 0), -2],
			[Vector2(-4, 0), -2],
		]

class ToppingSkyscraper extends BaseTopping:
	func _init():
		tile_index = 2 

	func get_influence():
		return [
			[Vector2(0, 0), -3],
			[Vector2(0, 1), -1],
			[Vector2(1, 0), -1],
			[Vector2(-1, 0), -1],
			[Vector2(0, -1), -1],
			[Vector2(-1, -1), -1],
			[Vector2(1, -1), -1],
			[Vector2(1, 1), -1],
			[Vector2(-1, 1), -1],
			[Vector2(0, 2), -1],
			[Vector2(2, 0), -1],
			[Vector2(-2, 0), -1],
			[Vector2(0, -2), -1],
			[Vector2(-2, -2), -1],
			[Vector2(2, -2), -1],
			[Vector2(2, 2), -1],
			[Vector2(-2, 2), -1],			
			[Vector2(1, 2), -1],
			[Vector2(2, 1), -1],
			[Vector2(-2, 1), -1],
			[Vector2(1, -2), -1],
			[Vector2(-1, 2), -1],
			[Vector2(2, -1), -1],
			[Vector2(-2, -1), -1],
			[Vector2(-1, -2), -1],
		]

class ToppingTrash extends BaseTopping:
	func _init():
		tile_index = 3

	func get_influence():
		return [
			[Vector2(0, 0), -5],
			[Vector2(0, 1), -5],
			[Vector2(1, 0), -5],
			[Vector2(-1, 0), -5],
			[Vector2(0, -1), -5],
			[Vector2(-1, -1), -5],
			[Vector2(1, -1), -5],
			[Vector2(1, 1), -5],
			[Vector2(-1, 1), -5],
		]

class ToppingFanyPowerPlant extends BaseTopping:
	func _init():
		tile_index = 4

	func get_influence():
		return [
			[Vector2(0, 0), -5],
			[Vector2(0, 1), -3],
			[Vector2(1, 0), -3],
			[Vector2(-1, 0), -3],
			[Vector2(0, -1), -3],
			[Vector2(-1, -1), -3],
			[Vector2(1, -1), -3],
			[Vector2(1, 1), -3],
			[Vector2(-1, 1), -3],
			[Vector2(0, 2), -2],
			[Vector2(2, 0), -2],
			[Vector2(-2, 0), -2],
			[Vector2(0, -2), -2],
			[Vector2(-2, -2), -2],
			[Vector2(2, -2), -2],
			[Vector2(2, 2), -2],
			[Vector2(-2, 2), -2],			
			[Vector2(1, 2), -2],
			[Vector2(2, 1), -2],
			[Vector2(-2, 1), -2],
			[Vector2(1, -2), -2],
			[Vector2(-1, 2), -2],
			[Vector2(2, -1), -2],
			[Vector2(-2, -1), -2],
			[Vector2(-1, -2), -2],
		]