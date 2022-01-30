const toppings = preload("res://Scripts/simulation/Toppings.gd")



class Simulation:
	var current_map
	var previous_map
	var map
	var _used_tiles = []
	
	var _industry
	var _nature

	func _init():
		map = load("res://Scripts/simulation/Map.gd")

		_industry = {
			1: toppings.ToppingHut.new(),
			2: toppings.ToppingTrash.new(),
			3: toppings.ToppingShop.new(),
			4: toppings.ToppingFanyPowerPlant.new(),
			5: toppings.ToppingSkyscraper.new(),
		}

		_nature = {
			1: toppings.ToppingTree.new(),
			2: toppings.ToppingHill.new(),
			3: toppings.ToppingBigTree.new(),
			4: toppings.ToppingSwamp.new(),
			5: toppings.ToppingNomNomPlant.new(),
		}

	func tick():
		print("Simulation tick")
		previous_map = current_map
		current_map = map.Map.new(_used_tiles)
		
		for prev_field in previous_map.fields.values():
			var pos = prev_field.pos
			var field = current_map.get_tile(pos.x, pos.y)
			if not field:
				# field outside of map
				continue
			
			var i_pos
			for influence in prev_field.duality_topping.get_influence():
				i_pos = pos + influence[0]
				var inf_field = current_map.get_tile(i_pos.x, i_pos.y)
				if inf_field:
					inf_field.duality += influence[1]
			
		# update toppings
		for field in current_map.fields.values():
			var s = 1
			if field.duality < 0:
				s = -1
			if abs(field.duality) > 5:
				field.duality = 5 * s
			
			var top_i = abs(field.duality)
			if top_i > 0:
				if s == -1:
					field.duality_topping = _industry[top_i]
				else:
					field.duality_topping = _nature[top_i]

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
