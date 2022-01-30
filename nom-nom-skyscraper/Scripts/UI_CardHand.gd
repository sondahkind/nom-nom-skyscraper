"""
Renders hand cards.

To integrate into scene: Add a Control Node under the UI Canvas Node, set its
	layout to bottom left and attach this script to the node.

To render a list of cards: Define an array of the hand cards to be rendered
	which have to be represented by IDs from UI_CardIDs and then call
	set_cards with that array.

To handle card click: This script will emit the signal card_clicked with the
	card ID of the clicked card.
"""

extends Node

# declare signals
signal card_clicked(card_id)

# Used for preloading textures in _ready()
var UI_CardIDs
var _textures_mapping = {}

# Position, scale and offset for the hand cards
const _card_scale = Vector2(0.25, 0.25)
const _base_position = Vector2(250, -100)
const _offset_per_card = Vector2(75, 0)

# Positon and scale for the hovered card
const _hover_position = Vector2(1250, -650)
const _hover_scale = Vector2(0.5, 0.5)

# Current hand cards
var cards = []

# Settings this to true will cause the hand cards to re-render
var cards_dirty = false

# Storage for textures
var _preloaded_textures = {}

# Reference to the hovered card node because it needs to be shown/hidden during
# runtime
var hovered_card

var current_card_nr = 0


func set_cards(new_cards):
	"""
	Call this with a string array of IDs defined in UI_CardIDs
	"""
	if new_cards == cards:
		return
	
	var valid_cards = []
	for card in new_cards:
		if not _textures_mapping.has(card):
			push_error("Card ID %s is not valid" % card)
			continue
		valid_cards.append(card)
	cards = valid_cards
	cards_dirty = true


# Called when the node enters the scene tree for the first time.
func _ready():
	# Get card ID strings and map textures to card IDs
	UI_CardIDs = get_node("/root/UI_CardIDs")
	_textures_mapping = {
		UI_CardIDs.TREE: "res://Assets/Cards/card_nature_tree.png",
		UI_CardIDs.HILL: "res://Assets/Cards/card_nature_hill.png",
		UI_CardIDs.LOOK_AT_THE_SIZE_OF_THIS_TREE: "res://Assets/Cards/card_nature_look_at_the_size_of_this_tree.png",
		UI_CardIDs.SWAMP: "res://Assets/Cards/card_nature_moor.png",
		UI_CardIDs.NOM_NOM_PLANT: "res://Assets/Cards/card_nature_nom_nom_plant.png",
		UI_CardIDs.HUT: "res://Assets/Cards/card_industrie_hut.png",
		UI_CardIDs.SHOP: "res://Assets/Cards/card_industrie_shop.png",
		UI_CardIDs.SKYSCRAPER: "res://Assets/Cards/card_industrie_skyscraper.png",
		UI_CardIDs.TOTALLY_NOT_A_TRASH_PILE: "res://Assets/Cards/card_industrie_totally_not_a_trash_pile.png",
		UI_CardIDs.FANCY_POWER_PLANT: "res://Assets/Cards/card_industrie_fancy_power_plant.png"
	}
	
	# preload textures
	for key in _textures_mapping.keys():
		_preloaded_textures[key] = load(_textures_mapping.get(key))
	
	# instantiate node for hovered card and hide it
	hovered_card = _construct_hovered_card(UI_CardIDs.TREE)
	hovered_card.hide()
	add_child(hovered_card)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not cards_dirty:
		_handle_card_hover()
		return
	
	# there probably is a more efficient way than re-drawing the entire hand on
	# any change but eh...
	_clear_children()
	var offset_x = Vector2(0, 0)
	var card_index = 0
	for card_id in cards:
		add_child(_construct_sprite(
			card_id,
			"HandCard_{ind}_{c_id}".format({"ind": card_index, "c_id": card_id}),
			_base_position + offset_x
		))
		offset_x += _offset_per_card
		card_index += 1
	cards_dirty = false
	_handle_card_hover()


func _on_button_clicked():
	# Godot naturally doesn't pass the button name along with the button press
	# signal (because why should it??) and we can't manually connect buttons for
	# dynamically created instances so here we go
	var card_under_mouse = _get_hovered_node()
	var card_id = _card_id_from_node(card_under_mouse)
	print_debug("Emitting click signal for card {c_id}".format({"c_id": card_id}))
	emit_signal("card_clicked", current_card_nr)


func _card_id_from_node(node):
	return node.name.split("_")[2]


func _get_hovered_node():
	current_card_nr = 0
	for child in get_children():
		current_card_nr = current_card_nr + 1 
		if child.is_hovered():
			return child


func _handle_card_hover():
	var hovered_child = _get_hovered_node()
	if not hovered_child:
		hovered_card.hide()
		return
	
	var hovered_id = _card_id_from_node(hovered_child)
	hovered_card.texture_normal = _preloaded_textures.get(hovered_id)
	hovered_card.show()


func _construct_sprite(card_id, name, position):
	var sprite = TextureButton.new()
	sprite.name = name
	sprite.texture_normal = _preloaded_textures.get(card_id)
	sprite.rect_position = position
	sprite.rect_scale = _card_scale
	sprite.connect("button_up", self, "_on_button_clicked")
	return sprite


func _construct_hovered_card(card_id):
	var sprite = _construct_sprite(card_id, "HoveredCard", _hover_position)
	sprite.rect_scale = _hover_scale
	return sprite


func _clear_children():
	for child in get_children():
		# Skip the node for the covered card because we only toggle its
		# visibility instead of deleting and re-adding it all the time
		if child.name == "HoveredCard":
			continue
		
		remove_child(child)
		child.queue_free()
