extends Object

class Card:

    var card_name = "no_name"
    var card_image = "res://Assets/Cards/card_nature_tree.png"
    var sprite
    # TODO add card stuff

    # Is the constructor is calles with Card.new() an creates new object
    func _init(card_name_new):
        self.card_name = card_name_new

    func set_card_values(card_name_new):
        self.card_name = card_name_new

    func display_card(drawing_node):
        sprite = Sprite.new()
        sprite.texture = load(card_image)
        drawing_node.add_child(sprite)
        #
