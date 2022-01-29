extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var buttonLabel = "Placeholder"
var currentPhase = 0
var is_in_phase = false

var ammount_of_cards_drawn = 3

var Card = preload("Card.gd")
const CardManager = preload("CardManager.gd")
var field_manager

var card_manager

const SETUP_PHASE = 0
const SETUP_END_PHASE = 1
const DRAW_PHASE = 2
const DRAW_END_PHASE = 3
const PLAY_CARD_PHASE = 4
const PLAY_CARD_END_PHASE = 5
const CALCULATION_PHASE = 6
const CALCULATION_END_PHASE = 7

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
		if (currentPhase == play_end_card_phase()):
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
	
func setup_end_phase():
	is_in_phase = true
	$CurrentPhaseLabel.set_text("setup_end_phase")

func draw_phase():
	is_in_phase = true
	$CurrentPhaseLabel.set_text("draw_phase")
	card_manager.draw_cards(ammount_of_cards_drawn)

func draw_end_phase():
	is_in_phase = true
	$CurrentPhaseLabel.set_text("draw_end_phase")

func play_card_phase():
	is_in_phase = true
	$CurrentPhaseLabel.set_text("play_card_phase")

func play_end_card_phase():
	is_in_phase = true
	$CurrentPhaseLabel.set_text("play_end_card_phase")

func calculation_phase():
	is_in_phase = true
	calculate_tiles()
	$CurrentPhaseLabel.set_text("calculation_phase")

func calculation_end_phase():
	is_in_phase = true
	$CurrentPhaseLabel.set_text("calculation_end_phase")

# --------------------------------------------------------------------------

func calculate_tiles():
	print(field_manager.get_wilderness())
	print(field_manager.get_industry())
	# this should be around 0 for a balanced game
	print(field_manager.get_overall_values())

func next_phase():
	if (currentPhase <=7):
		currentPhase = currentPhase + 1
	else:
		currentPhase = 1
	is_in_phase = false

func create_cards_and_add_to_deck():
	# Wilderness
	var tree_card = Card.Card.new("Baum")
	var hill_card = Card.Card.new("Hügelchen")
	var look_at_the_size_of_this_tree_card = Card.Card.new("Jahrhundertbaun")
	var moor_card = Card.Card.new("Moor")
	var nom_nom_plant_card = Card.Card.new("Nom Nom Pflanze")

	card_manager.add_cards_to_deck(tree_card, 5)
	card_manager.add_cards_to_deck(hill_card, 4)
	card_manager.add_cards_to_deck(look_at_the_size_of_this_tree_card, 3)
	card_manager.add_cards_to_deck(moor_card, 2)
	card_manager.add_cards_to_deck(nom_nom_plant_card, 1)

	# Industrie
	var hut_card = Card.Card.new("Hütte")
	var shop_card = Card.Card.new("Geschäft")
	var skyscraper_card = Card.Card.new("Hochhaus")
	var totally_not_a_trash_pile_card = Card.Card.new("Recycling-Station")
	var fancy_power_plant = Card.Card.new("Kraftwerk")

	card_manager.add_cards_to_deck(hut_card, 5)
	card_manager.add_cards_to_deck(shop_card, 4)
	card_manager.add_cards_to_deck(skyscraper_card, 3)
	card_manager.add_cards_to_deck(totally_not_a_trash_pile_card, 2)
	card_manager.add_cards_to_deck(fancy_power_plant, 1)
