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

var UI_CardIDs
var map_progress

# Called when the node enters the scene tree for the first time.
func _ready():
	UI_CardIDs = get_node("/root/UI_CardIDs")
	var ui_hand_cards_node = get_node("../UI/HandCards")
	map_progress = get_node("../UI/MapProgress")
	Global.bus.emit_map_refresh()
	card_manager = CardManager.CardManager.new(ui_hand_cards_node)
	
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
	create_hut_and_tree_and_add_to_deck()
	card_manager.shuffle_deck()
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
	print("-> win? ", _current_win(stats))
	map_progress.set_industry_progress(stats["industry_perc"])
	map_progress.set_nature_progress(stats["wilderness_perc"])

	var game_finished = card_manager.game_finished()
	if stats["industry_perc"] > 75:
		game_finished = true

	if stats["wilderness_perc"] > 75:
		game_finished = true

	if game_finished:
		# calculate if player won or loose
		if _current_win(stats):
			get_tree().change_scene("res://Scenes/Lose.tscn")
		else:
			get_tree().change_scene("res://Scenes/Win.tscn")
	next_phase()


func _current_win(stats):
	if stats["industry_perc"] > 75:
		return false

	if stats["industry_perc"] < 25:
		return false

	if stats["wilderness_perc"] > 75:
		return false

	if stats["wilderness_perc"] < 25:
		return false

	var perc_point_diff = stats["wilderness_perc"] - stats["industry_perc"]

	if perc_point_diff > 25:
		return false
	
	return true

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


	var hill_card = Card.Card.new("Hügelchen", UI_CardIDs.HILL, "res://Assets/Cards/card_nature_hill.png")
	hill_card.card_type = WILDERNESS
	hill_card.card_topping = Toppings.ToppingHill.new()

	var look_at_the_size_of_this_tree_card = Card.Card.new(
		"Jahrhundertbaun",
		UI_CardIDs.LOOK_AT_THE_SIZE_OF_THIS_TREE,
		"res://Assets/Cards/card_nature_look_at_the_size_of_this_tree.png"
	)
	look_at_the_size_of_this_tree_card.card_type = WILDERNESS
	look_at_the_size_of_this_tree_card.card_topping = Toppings.ToppingBigTree.new()

	var moor_card = Card.Card.new("Moor", UI_CardIDs.SWAMP, "res://Assets/Cards/card_nature_moor.png")
	moor_card.card_type = WILDERNESS
	moor_card.card_topping = Toppings.ToppingSwamp.new()

	var nom_nom_plant_card = Card.Card.new(
		"Nom Nom Pflanze",
		UI_CardIDs.NOM_NOM_PLANT,
		"res://Assets/Cards/card_nature_nom_nom_plant.png"
	)
	nom_nom_plant_card.card_type = WILDERNESS
	nom_nom_plant_card.card_topping = Toppings.ToppingNomNomPlant.new()

	card_manager.add_cards_to_deck(hill_card, 4)
	card_manager.add_cards_to_deck(look_at_the_size_of_this_tree_card, 3)
	card_manager.add_cards_to_deck(moor_card, 2)
	card_manager.add_cards_to_deck(nom_nom_plant_card, 1)

	# Industrie
	var shop_card = Card.Card.new("Geschäft", UI_CardIDs.SHOP, "res://Assets/Cards/card_industrie_shop.png")
	shop_card.card_type = INDUSTRY
	shop_card.card_topping = Toppings.ToppingShop.new()
	
	var skyscraper_card = Card.Card.new("Hochhaus", UI_CardIDs.SKYSCRAPER, "res://Assets/Cards/card_industrie_skyscraper.png")
	skyscraper_card.card_type = INDUSTRY
	skyscraper_card.card_topping = Toppings.ToppingSkyscraper.new()
	
	var totally_not_a_trash_pile_card = Card.Card.new(
		"Recycling-Station",
		UI_CardIDs.TOTALLY_NOT_A_TRASH_PILE,
		"res://Assets/Cards/card_industrie_totally_not_a_trash_pile.png"
	)
	totally_not_a_trash_pile_card.card_type = INDUSTRY
	totally_not_a_trash_pile_card.card_topping = Toppings.ToppingTrash.new()
	
	var fancy_power_plant = Card.Card.new(
		"Kraftwerk",
		UI_CardIDs.FANCY_POWER_PLANT,
		"res://Assets/Cards/card_industrie_fancy_power_plant.png"
	)
	fancy_power_plant.card_type = INDUSTRY
	fancy_power_plant.card_topping = Toppings.ToppingFanyPowerPlant.new()

	card_manager.add_cards_to_deck(shop_card, 4)
	card_manager.add_cards_to_deck(skyscraper_card, 3)
	card_manager.add_cards_to_deck(totally_not_a_trash_pile_card, 2)
	card_manager.add_cards_to_deck(fancy_power_plant, 1)

func create_hut_and_tree_and_add_to_deck():
	var tree_card = Card.Card.new("Baum", UI_CardIDs.TREE, "res://Assets/Cards/card_nature_tree.png")
	tree_card.card_type = WILDERNESS
	tree_card.card_topping = Toppings.ToppingTree.new()
	card_manager.add_cards_to_deck(tree_card, 5)

	var hut_card = Card.Card.new("Hütte", UI_CardIDs.HUT, "res://Assets/Cards/card_industrie_hut.png")
	hut_card.card_type = INDUSTRY
	hut_card.card_topping = Toppings.ToppingHut.new()
	card_manager.add_cards_to_deck(hut_card, 5)


func renderHandCards():
	card_manager.display_cards()
	
func hideHandCards():
	card_manager.hide_cards()

func get_card_manager():
	return card_manager


func _on_HandCards_card_clicked(card_id):
	card_manager.play_card(self, (card_id-2))
