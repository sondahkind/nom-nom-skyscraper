const Toppings = preload("Toppings.gd")

const MAX_VALUE = 10

class Field:
	# position in tileset coordinates
	var pos: Vector2
	var duality: int = 0
	var duality_topping = Toppings.BaseTopping.new()

	# -1 = no topping
	# 1 = Tree / Hut


	func base_type():
		if duality < 0:
			return 0
		elif duality > 0:
			return 1
		return 2
