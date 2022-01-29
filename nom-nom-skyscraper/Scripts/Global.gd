extends Node

const _simulation = preload("res://Scripts/simulation/Simulation.gd")

var sim = _simulation.Simulation.new()


class Bus:
	signal map_refresh
	
	func emit_map_refresh():
		print("emit map_refresh")
		emit_signal("map_refresh")


var bus = Bus.new()
