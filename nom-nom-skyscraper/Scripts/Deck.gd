extends Object

class Deck:

    var deck = [] 

    # TODO add Deck stuff

    # Is the constructor is calles with Deck.new() an creates new object
    func _init(deck_size):
        self.deck_size = deck_size
        pass

    func add_cards(card, ammount):
        for x in ammount:
            deck.append(card)


    func shuffle():
        var shuffled_deck = []
        while deck.size() > 0:
            var rng = RandomNumberGenerator.new()
            rng.randomize()
            var card_number = rng.randi_range(0, deck.size())
            shuffled_deck.append(deck[card_number])
            deck.remove(card_number)
        deck = shuffled_deck

    func draw_top_card():
        return deck.pop_front() 

