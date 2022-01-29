extends Object

class Deck:

	var deck = [] 

	# TODO add Deck stuff

	# Is the constructor is calles with Deck.new() an creates new object
	func _init():
		pass

	func add_cards(card, ammount):
		for x in ammount:
			deck.append(card)


	func shuffle():
		var shuffled_deck = []
        #Todo
		while deck.size() > 0:
			print(deck.size())
			var rng = RandomNumberGenerator.new()
			rng.randomize()
			var card_number = rng.randi_range(0, (deck.size()-1))
			shuffled_deck.append(deck[card_number])
			deck.remove(card_number)
		deck = shuffled_deck

	func draw_top_card():
		if (deck.size() > 0):
			return deck.pop_front() 
		else:
			return null

