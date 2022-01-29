const MAX_VALUE = 10

class Field:
	# position in tileset coordinates
	var pos: Vector2
	var duality: int = 0
	var duality_topping: int = -1

	# -1 = no topping
	# 1 = Tree / Hut

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

	func base_type():
		if duality < 0:
			return 0
		elif duality > 0:
			return 1
		return 2
