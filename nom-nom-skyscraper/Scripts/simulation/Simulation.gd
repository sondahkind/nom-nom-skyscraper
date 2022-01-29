

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
		
		# for tile in current_map.

		return map

	func used_tile(x, y):
		_used_tiles.append(Vector2(x, y))
	
	func used_tiles_marked():
		current_map = map.Map.new(_used_tiles)

	func get_overall_duality():
		var duality = 0
		for field in self.current_map.fields:
			duality += field.duality
		return duality

	func stats():
		var stats = {
			"wilderness_count": 0,
			"industry_count": 0,
			"neutral_count": 0,
			"wilderness_perc": 0,
			"industry_perc": 0,
			"duality": 0,
		}
		for field in self.current_map.fields.values():
			var base_type = field.base_type()
			if base_type == 0:
				stats["wilderness_count"] += 1
			elif base_type == 1:
				stats["industry_count"] += 1
			elif base_type == 2:
				stats["neutral_count"] += 1
			stats["duality"] += field.duality
		
		var count = stats["neutral_count"] + stats["industry_count"] + stats["wilderness_count"]
		stats["wilderness_perc"] = stats["wilderness_count"] / count * 100
		stats["industry_perc"] = stats["industry_count"] / count * 100
		return stats
