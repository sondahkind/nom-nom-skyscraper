const toppings = preload("res://Scripts/simulation/Toppings.gd")

class Simulation:
	var current_map
	var previous_map
	var map
	var _used_tiles = []

	func _init():
		map = load("res://Scripts/simulation/Map.gd")

	func tick():
		print("Simulation tick")
		previous_map = current_map
		current_map = map.Map.new(_used_tiles)
		
		# copy all toppings
		for prev_field in previous_map.fields.values():
			var pos = prev_field.pos
			var field = current_map.get_tile(pos.x, pos.y)
			if not field:
				# field outside of map
				continue
			field.duality_topping = prev_field.duality_topping
			var i_pos
			for influence in field.duality_topping.get_influence():
				i_pos = pos + influence[0]
				var inf_field = current_map.get_tile(i_pos.x, i_pos.y)
				if inf_field:
					inf_field.duality += influence[1]

		# kill off toppings with wrong soil
		for field in current_map.fields.values():
			if field.duality_topping.duality == 0:
				continue
				
			if sign(field.duality_topping.duality) != sign(field.duality):
				field.duality_topping = toppings.BaseTopping.new()

		# grow!
		for field in current_map.fields.values():
			if field.duality_topping.duality != 0:
				# ignore fields with topping already existing
				continue
				
			if abs(field.duality) < 4:
				continue
			
			if sign(field.duality) == -1:
				field.duality_topping = toppings.ToppingHut.new()
			else:
				field.duality_topping = toppings.ToppingTree.new()

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
				stats["industry_count"] += 1
			elif base_type == 1:
				stats["wilderness_count"] += 1
			elif base_type == 2:
				stats["neutral_count"] += 1
			stats["duality"] += field.duality
		
		var count = stats["neutral_count"] + stats["industry_count"] + stats["wilderness_count"]
		stats["wilderness_perc"] = stats["wilderness_count"] * 100 / count 
		stats["industry_perc"] = stats["industry_count"] * 100 / count
		return stats
