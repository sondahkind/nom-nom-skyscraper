const MAX_VALUE = 10

class Field:
	# position in tileset coordinates
	var pos: Vector2
	var duality: int = 0

	func add_wilderness(value):
		if duality + value > MAX_VALUE:
			duality = MAX_VALUE
		else:
			duality += value
	
	func add_industry(value):
		if duality - value < -MAX_VALUE:
			duality = -MAX_VALUE
		else:
			duality -= value
