extends Object

class Card:
	var card_name = "no_name"
	var card_image = "res://Assets/Cards/card_nature_tree.png"
	var sprite
	# TODO add card stuff

	# Is the constructor is calles with Card.new() an creates new object
	func _init(card_name_new, card_image_path):
		self.card_name = card_name_new
		card_image = card_image_path
		pass

	func set_card_values(card_name_new):
		self.card_name = card_name_new
	
	func hide_card(drawing_node):
		if (drawing_node.get_child_count() > 0):
			drawing_node.remove_child(drawing_node.get_child(0))
		drawing_node.disabled = true

	func display_card(drawing_node):
		if (drawing_node.get_child_count() > 0):
			drawing_node.remove_child(drawing_node.get_child(0))
		drawing_node.disabled = false
		sprite = Sprite.new()
		sprite.texture = load(card_image)
		sprite.scale = Vector2(0.35, 0.35)
		sprite.position.x = 167
		sprite.position.y = 227
		drawing_node.add_child(sprite)

