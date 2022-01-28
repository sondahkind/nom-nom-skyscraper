extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var buttonLabel = "Placeholder"
var currentPhase = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	currentPhase = 0
	phase_manager()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# get_node("CurrentPhaseLabel").text = "pre_phase"
	phase_manager()
	pass

func phase_manager():
	if (currentPhase == 0):
		setup_phase()
	if (currentPhase == 1):
		setup_end_phase()
	if (currentPhase == 2):
		draw_phase()
	if (currentPhase == 3):
		draw_end_phase()
	if (currentPhase == 4):
		play_card_phase()
	if (currentPhase == 5):
		play_end_card_phase()
	if (currentPhase == 6):
		calculation_phase()
	if (currentPhase == 7):
		calculation_end_phase()

# -------------------------------------PHASES-------------------------------------

func setup_phase():
	$CurrentPhaseLabel.set_text("setup_phase")
	
func setup_end_phase():
	$CurrentPhaseLabel.set_text("setup_end_phase")

func draw_phase():
	$CurrentPhaseLabel.set_text("draw_phase")
	draw_cards(1)

func draw_end_phase():
	$CurrentPhaseLabel.set_text("draw_end_phase")
	draw_cards(1)	

func play_card_phase():
	$CurrentPhaseLabel.set_text("play_card_phase")

func play_end_card_phase():
	$CurrentPhaseLabel.set_text("play_end_card_phase")

func calculation_phase():
	$CurrentPhaseLabel.set_text("calculation_phase")

func calculation_end_phase():
	$CurrentPhaseLabel.set_text("calculation_end_phase")

# --------------------------------------------------------------------------

func next_phase():
	if (currentPhase <=7):
		currentPhase = currentPhase + 1
	else:
		currentPhase = 0

func draw_cards(numberOfCards):
	pass