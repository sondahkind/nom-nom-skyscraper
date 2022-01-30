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
	var ui_node

	func _init(p_ui_node):
		self.ui_node = p_ui_node
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
		hide_cards()
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

	func display_cards():
		# display all hand cards
		var hand_card_ids = []
		for card in hand_cards:
			hand_card_ids.append(card.card_id)
		ui_node.set_cards(hand_card_ids)

	func hide_cards():
		# hide all hand cards
		ui_node.set_cards([])

	func get_hand_size():
		return hand_cards.size()
