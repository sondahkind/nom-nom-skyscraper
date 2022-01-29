extends TextureButton

export var cardNr = 0

func _pressed(): 
	var game_logic_node = get_node("/root/Node2D/GameLogic")
	game_logic_node.card_manager.play_card(self)
