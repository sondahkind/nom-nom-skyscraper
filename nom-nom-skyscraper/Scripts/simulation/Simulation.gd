

class Simulation:
	var current_map
	var previous_map
	var map

	func _init():
		map = load("res://Scripts/simulation/Map.gd")
		current_map = map.Map.new()

	func tick():
		print("Simulation tick")
		previous_map = current_map
		current_map = map.Map.new()
		
		return map
