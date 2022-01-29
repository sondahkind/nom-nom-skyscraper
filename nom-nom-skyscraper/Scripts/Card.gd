extends Object

class Card:
	var card_name = "no_name"
	var card_image = "res://Assets/Cards/card_nature_tree.png"
	var sprite
	var texture

	const INDUSTRY = 0
	const WILDERNESS = 1

	var card_type
	var card_intensity
	var card_radius
	var card_topping
	# TODO add card stuff

	# Is the constructor is calles with Card.new() an creates new object
	func _init(card_name_new, card_image_path):
		self.card_name = card_name_new
		texture = load(card_image_path)

	func set_card_values(card_name_new):
		self.card_name = card_name_new
	
	func hide_card(drawing_node):
		if (drawing_node.get_child_count() > 0):
			drawing_node.remove_child(drawing_node.get_child(0))
		drawing_node.visible = false
		drawing_node.disabled = true

	func display_card(drawing_node):
		if (drawing_node.get_child_count() > 0):
			drawing_node.remove_child(drawing_node.get_child(0))
		drawing_node.visible = true
		drawing_node.disabled = false
		sprite = Sprite.new()
		sprite.texture = texture
		sprite.scale = Vector2(0.35, 0.35)
		sprite.position.x = 167
		sprite.position.y = 227
		drawing_node.add_child(sprite)

