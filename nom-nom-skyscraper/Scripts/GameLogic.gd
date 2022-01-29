extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var buttonLabel = "Placeholder"
var currentPhase = 0
var is_in_phase = false

export var ammount_of_cards_drawn_at_start = 3
export var ammount_of_cards_drawn_at_draw_phase = 1
export var max_hand_size = 4

var Card = preload("Card.gd")
const CardManager = preload("CardManager.gd")
const Toppings = preload("simulation/Toppings.gd")

var card_manager

const SETUP_PHASE = 0
const SETUP_END_PHASE = 1
const DRAW_PHASE = 2
const DRAW_END_PHASE = 3
const PLAY_CARD_PHASE = 4
const PLAY_CARD_END_PHASE = 5
const CALCULATION_PHASE = 6
const CALCULATION_END_PHASE = 7

const INDUSTRY = 0
const WILDERNESS = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.bus.emit_map_refresh()
	card_manager = CardManager.CardManager.new()
	currentPhase = SETUP_PHASE
	phase_manager()


func _process(delta):
	# get_node("CurrentPhaseLabel").text = "pre_phase"
	phase_manager()


func phase_manager():
	if (is_in_phase != true):
		if (currentPhase == SETUP_PHASE):
			setup_phase()
		if (currentPhase == SETUP_END_PHASE):
			setup_end_phase()
		if (currentPhase == DRAW_PHASE):
			draw_phase()
		if (currentPhase == DRAW_END_PHASE):
			draw_end_phase()
		if (currentPhase == PLAY_CARD_PHASE):
			play_card_phase()
		if (currentPhase == PLAY_CARD_END_PHASE):
			play_end_card_phase()
		if (currentPhase == CALCULATION_PHASE):
			calculation_phase()
		if (currentPhase == CALCULATION_END_PHASE):
			calculation_end_phase()

# -------------------------------------PHASES-------------------------------------

func setup_phase():
	is_in_phase = true
	create_cards_and_add_to_deck()
	card_manager.shuffle_deck()
	#Basic Deck filling example
	next_phase()
	
func setup_end_phase():
	is_in_phase = true
	card_manager.draw_cards(ammount_of_cards_drawn_at_start)
	next_phase()

func draw_phase():
	is_in_phase = true
	if (card_manager.get_hand_size() < max_hand_size):
		card_manager.draw_cards(ammount_of_cards_drawn_at_draw_phase)

	renderHandCards()

func draw_end_phase():
	is_in_phase = true
	hideHandCards()
	next_phase()

func play_card_phase():
	is_in_phase = true

func play_end_card_phase():
	is_in_phase = true
	next_phase()

func calculation_phase():
	is_in_phase = true
	Global.sim.tick()
	Global.bus.emit_map_refresh()
	var stats = Global.sim.stats()
	print(stats)
	if card_manager.game_finished():
		# calculate if player won or loose
		if (abs(stats["duality"]) > 10):
			get_tree().change_scene("res://Scenes/Lose.tscn")
		else:
			get_tree().change_scene("res://Scenes/Win.tscn")
	next_phase()

func calculation_end_phase():
	is_in_phase = true
	next_phase()
	print(currentPhase)

# --------------------------------------------------------------------------

func next_phase():
	if (currentPhase < 7):
		currentPhase = currentPhase + 1
	else:
		currentPhase = 2
	is_in_phase = false

func create_cards_and_add_to_deck():
	# Wilderness
	var tree_card = Card.Card.new("Baum", "res://Assets/Cards/card_nature_tree.png")
	tree_card.card_type = WILDERNESS
	tree_card.card_topping = Toppings.ToppingTree.new()

	var hill_card = Card.Card.new("Hügelchen", "res://Assets/Cards/card_nature_hill.png")
	hill_card.card_type = WILDERNESS
	hill_card.card_topping = Toppings.ToppingHill.new()

	var look_at_the_size_of_this_tree_card = Card.Card.new("Jahrhundertbaun", "res://Assets/Cards/card_nature_look_at_the_size_of_this_tree.png")
	look_at_the_size_of_this_tree_card.card_type = WILDERNESS
	look_at_the_size_of_this_tree_card.card_topping = Toppings.ToppingBigTree.new()

	var moor_card = Card.Card.new("Moor", "res://Assets/Cards/card_nature_moor.png")
	moor_card.card_type = WILDERNESS
	moor_card.card_topping = Toppings.ToppingMoot.new()

	var nom_nom_plant_card = Card.Card.new("Nom Nom Pflanze", "res://Assets/Cards/card_nature_nom_nom_plant.png")
	nom_nom_plant_card.card_type = WILDERNESS
	nom_nom_plant_card.card_topping = Toppings.ToppingNomNomPlant.new()

	card_manager.add_cards_to_deck(tree_card, 5)
	card_manager.add_cards_to_deck(hill_card, 4)
	card_manager.add_cards_to_deck(look_at_the_size_of_this_tree_card, 3)
	card_manager.add_cards_to_deck(moor_card, 2)
	card_manager.add_cards_to_deck(nom_nom_plant_card, 1)

	# Industrie
	var hut_card = Card.Card.new("Hütte", "res://Assets/Cards/card_industrie_hut.png")
	hut_card.card_type = INDUSTRY
	hut_card.card_topping = Toppings.ToppingHut.new()

	var shop_card = Card.Card.new("Geschäft", "res://Assets/Cards/card_industrie_shop.png")
	shop_card.card_type = INDUSTRY
	shop_card.card_topping = Toppings.ToppingShop.new()
	
	var skyscraper_card = Card.Card.new("Hochhaus", "res://Assets/Cards/card_industrie_skyscraper.png")
	skyscraper_card.card_type = INDUSTRY
	skyscraper_card.card_topping = Toppings.ToppingSkyscraper.new()
	
	var totally_not_a_trash_pile_card = Card.Card.new("Recycling-Station", "res://Assets/Cards/card_industrie_totally_not_a_trash_pile.png")
	totally_not_a_trash_pile_card.card_type = INDUSTRY
	totally_not_a_trash_pile_card.card_topping = Toppings.ToppingTrash.new()
	
	var fancy_power_plant = Card.Card.new("Kraftwerk", "res://Assets/Cards/card_industrie_fancy_power_plant.png")
	fancy_power_plant.card_type = INDUSTRY
	fancy_power_plant.card_topping = Toppings.ToppingFanyPowerPlant.new()

	card_manager.add_cards_to_deck(hut_card, 5)
	card_manager.add_cards_to_deck(shop_card, 4)
	card_manager.add_cards_to_deck(skyscraper_card, 3)
	card_manager.add_cards_to_deck(totally_not_a_trash_pile_card, 2)
	card_manager.add_cards_to_deck(fancy_power_plant, 1)


func renderHandCards():
	var main_node = get_node("/root/Node2D/UI/CardHand")
	card_manager.display_cards(main_node)
	
func hideHandCards():
	var main_node = get_node("/root/Node2D/UI/CardHand")
	card_manager.hide_cards(main_node)

func get_card_manager():
	return card_manager
