

class Simulation:
	var current_map
	var previous_map
	var map
	var _used_tiles = []

	func _init():
		map = load("res://Scripts/simulation/Map.gd")

	func tick():
		print("Simulation tick")
		# previous_map = current_map
		# current_map = map.Map.new()
		
		return map

	func used_tile(x, y):
		_used_tiles.append(Vector2(x, y))
	
	func used_tiles_marked():
		current_map = map.Map.new(_used_tiles)
