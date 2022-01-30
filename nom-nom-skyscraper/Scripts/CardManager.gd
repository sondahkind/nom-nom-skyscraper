extends Object

class CardManager:
	# amount of cards we want to play
	export var play_cards = 15
	var cards_played = 0
	
	var Card = preload("Card.gd")
	const Deck = preload("Deck.gd")
	var current_card

	var deck
	var hand_cards = []

	func _init():
		deck = Deck.Deck.new()

	func add_cards_to_deck(card, ammount):
		deck.add_cards(card, ammount)

	func shuffle_deck():
		deck.shuffle()
	
	func play_card(game_logic_node, card_node: TextureButton):
		var nr = card_node.cardNr
		# play a hand card
		var card = hand_cards[nr]
		current_card = card
		print("play hand card: " + card.card_name)
		hide_cards(card_node.get_parent())
		# remove card from deck
		hand_cards.remove(nr)
		cards_played += 1
		# end draw phase
		game_logic_node.next_phase()

	func game_finished():
		return cards_played >= play_cards
	
	func draw_cards(numberOfCards):
		# draw hand cards
		for x in numberOfCards:
			var card = deck.draw_top_card()
			hand_cards.append(card)
			if (card != null):
				print(card.card_name)

	func display_cards(drawing_node):
		# display all hand cards
		var x=0
		for card in hand_cards:
			card.display_card(drawing_node.get_child(x))
			x = x + 1

	func hide_cards(drawing_node):
		# hide all hand cards
		var x=0
		for card in hand_cards:
			card.hide_card(drawing_node.get_child(x))
			x = x + 1

	func get_hand_size():
		return hand_cards.size()

		
