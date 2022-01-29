extends Object

class CardManager:

	var deckHand
	var Card = preload("Card.gd")
	const Deck = preload("Deck.gd")

	var deck
	var hand_cards = []

	func _init():
		deck = Deck.Deck.new()
		pass

	func add_cards_to_deck(card, ammount):
		deck.add_cards(card, ammount)

	func shuffle_deck():
		pass
		deck.shuffle()
	
	func draw_cards(numberOfCards):
		for x in numberOfCards:
			var card = deck.draw_top_card()
			hand_cards.append(card)
			if (card != null):
				print(card.card_name)

	func display_cards(drawing_node):
		var x=0
		for card in hand_cards:
			card.display_card(drawing_node.get_child(x))
			x = x+1

	func hide_cards(drawing_node):
		var x=0
		for card in hand_cards:
			card.hide_card(drawing_node.get_child(x))
			x = x+1

	func get_hand_size():
		return hand_cards.size()
