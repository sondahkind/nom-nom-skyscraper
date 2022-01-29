extends Object

class Card:

    var card_name = "no_name"
    var card_image = "res://Assets/Tiles/green_tile.png"
    var sprite
    # TODO add card stuff

    # Is the constructor is calles with Card.new() an creates new object
    func _init(card_name_new):
        self.card_name = card_name_new

    func set_card_values(card_name_new):
        self.card_name = card_name_new

    func display_card():
        sprite = Sprite.new()
        sprite.texture = load(card_image)
        #var game_logic_node = get_node("/root/Node2D/GameLogic")
