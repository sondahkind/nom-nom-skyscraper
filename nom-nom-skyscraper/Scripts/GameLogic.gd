extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var buttonLabel = "Placeholder"
var currentPhase = 0
var is_in_phase = false

var ammount_of_cards_drawn_at_start = 2
var ammount_of_cards_drawn_at_draw_phase = 1
var max_hand_size = 4

var Card = preload("Card.gd")
const CardManager = preload("CardManager.gd")
var field_manager

var card_manager

signal map_refresh

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
	field_manager = get_node("/root/Node2D/FieldManager")
	card_manager = CardManager.CardManager.new()
	currentPhase = SETUP_PHASE
	phase_manager()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# get_node("CurrentPhaseLabel").text = "pre_phase"
	phase_manager()
	pass

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
	$CurrentPhaseLabel.set_text("setup_phase")
	next_phase()
	
func setup_end_phase():
	is_in_phase = true
	card_manager.draw_cards(ammount_of_cards_drawn_at_start)
	$CurrentPhaseLabel.set_text("setup_end_phase")
	next_phase()

func draw_phase():
	is_in_phase = true
	$CurrentPhaseLabel.set_text("draw_phase")
	if (card_manager.get_hand_size() < max_hand_size):
		card_manager.draw_cards(ammount_of_cards_drawn_at_draw_phase)

	renderHandCards()

func draw_end_phase():
	is_in_phase = true
	hideHandCards()
	next_phase()
	$CurrentPhaseLabel.set_text("draw_end_phase")
	next_phase()

func play_card_phase():
	is_in_phase = true
	$CurrentPhaseLabel.set_text("play_card_phase")

func play_end_card_phase():
	is_in_phase = true
	$CurrentPhaseLabel.set_text("play_end_card_phase")
	next_phase()

func calculation_phase():
	is_in_phase = true
	calculate_tiles()
	$CurrentPhaseLabel.set_text("calculation_phase")
	next_phase()

func calculation_end_phase():
	is_in_phase = true
	$CurrentPhaseLabel.set_text("calculation_end_phase")
	next_phase()
	print(currentPhase)

# --------------------------------------------------------------------------

func calculate_tiles():
	print(field_manager.get_wilderness())
	print(field_manager.get_industry())
	# this should be around 0 for a balanced game
	print(field_manager.get_overall_values())
	emit_signal("map_refresh")

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
	tree_card.card_intensity = 1
	tree_card.card_radius = 1

	var hill_card = Card.Card.new("Hügelchen", "res://Assets/Cards/card_nature_hill.png")
	hill_card.card_type = WILDERNESS
	hill_card.card_intensity = 1
	hill_card.card_radius = 1

	var look_at_the_size_of_this_tree_card = Card.Card.new("Jahrhundertbaun", "res://Assets/Cards/card_nature_look_at_the_size_of_this_tree.png")
	look_at_the_size_of_this_tree_card.card_type = WILDERNESS
	look_at_the_size_of_this_tree_card.card_intensity = 1
	look_at_the_size_of_this_tree_card.card_radius = 1

	var moor_card = Card.Card.new("Moor", "res://Assets/Cards/card_nature_moor.png")
	moor_card.card_type = WILDERNESS
	moor_card.card_intensity = 1
	moor_card.card_radius = 1

	var nom_nom_plant_card = Card.Card.new("Nom Nom Pflanze", "res://Assets/Cards/card_nature_nom_nom_plant.png")
	nom_nom_plant_card.card_type = WILDERNESS
	nom_nom_plant_card.card_intensity = 1
	nom_nom_plant_card.card_radius = 1

	card_manager.add_cards_to_deck(tree_card, 5)
	card_manager.add_cards_to_deck(hill_card, 4)
	card_manager.add_cards_to_deck(look_at_the_size_of_this_tree_card, 3)
	card_manager.add_cards_to_deck(moor_card, 2)
	card_manager.add_cards_to_deck(nom_nom_plant_card, 1)

	# Industrie
	var hut_card = Card.Card.new("Hütte", "res://Assets/Cards/card_industrie_hut.png")
	hut_card.card_type = INDUSTRY
	hut_card.card_intensity = 1
	hut_card.card_radius = 1

	var shop_card = Card.Card.new("Geschäft", "res://Assets/Cards/card_industrie_shop.png")
	shop_card.card_type = INDUSTRY
	shop_card.card_intensity = 1
	shop_card.card_radius = 1
	
	var skyscraper_card = Card.Card.new("Hochhaus", "res://Assets/Cards/card_industrie_skyscraper.png")
	skyscraper_card.card_type = INDUSTRY
	skyscraper_card.card_intensity = 1
	skyscraper_card.card_radius = 1
	
	var totally_not_a_trash_pile_card = Card.Card.new("Recycling-Station", "res://Assets/Cards/card_industrie_totally_not_a_trash_pile.png")
	totally_not_a_trash_pile_card.card_type = INDUSTRY
	totally_not_a_trash_pile_card.card_intensity = 1
	totally_not_a_trash_pile_card.card_radius = 1
	
	var fancy_power_plant = Card.Card.new("Kraftwerk", "res://Assets/Cards/card_industrie_fancy_power_plant.png")
	fancy_power_plant.card_type = INDUSTRY
	fancy_power_plant.card_intensity = 1
	fancy_power_plant.card_radius = 1

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
