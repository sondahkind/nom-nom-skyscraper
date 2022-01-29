extends Object

class Card:

	var card_name = "no_name"
	var card_image = "res://Assets/Cards/card_nature_tree.png"
	var sprite
	# TODO add card stuff

	# Is the constructor is calles with Card.new() an creates new object
	func _init(card_name_new):
		self.card_name = card_name_new
		pass

	func set_card_values(card_name_new):
		self.card_name = card_name_new
	

	func display_card(drawing_node):
		if (drawing_node.get_child_count() > 0):
			drawing_node.remove_child(drawing_node.get_child(0))

		sprite = Sprite.new()
		sprite.texture = load(card_image)
		sprite.scale = Vector2(0.35, 0.35)
		drawing_node.add_child(sprite)

