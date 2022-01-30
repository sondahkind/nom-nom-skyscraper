extends Node2D

func _ready():
	pass

func _process(delta):
	var stats = Global.sim.stats()
	var lose_node_industry_value = get_node("/root/LoseMainNode/IndustryValue/Value")
	lose_node_industry_value.text = str(stats["industry_count"])
	var lose_node_industry_percantage = get_node("/root/LoseMainNode/IndustryPercantage/Value")
	lose_node_industry_percantage.text = str(stats["industry_perc"])
	var lose_node_Wilderness_value = get_node("/root/LoseMainNode/WildernessValue/Value")
	lose_node_Wilderness_value.text = str(stats["wilderness_count"])
	var lose_node_Wilderness_percantage = get_node("/root/LoseMainNode/WildernessPercantage/Value")
	lose_node_Wilderness_percantage.text = str(stats["wilderness_perc"])
