extends Object

class CardManager:

	var Card = preload("Card.gd")
	const Deck = preload("Deck.gd")

	var deck

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
			if (card != null):
				print(card.card_name)
