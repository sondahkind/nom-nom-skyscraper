extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var buttonLabel = "Placeholder"
var currentPhase = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	currentPhase = "setup_phase"
	phase_manager()



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func phase_manager():
	if (currentPhase == "setup_phase"):
		setup_phase()
	if (currentPhase == "draw_phase"):
		draw_phase()
	if (currentPhase == "play_card_phase"):
		play_card_phase()
	if (currentPhase == "calculation_phase"):
		calculation_phase()

func setup_phase():
	$CurrentPhaseLabel.set_text("setup_phase")
	pass

func draw_phase():
	$CurrentPhaseLabel.set_text("calculation_phase")
	draw_cards(1)
	pass

func play_card_phase():
	$CurrentPhaseLabel.set_text("calculation_phase")
	pass 

func calculation_phase():
	$CurrentPhaseLabel.set_text("calculation_phase")
	pass

func draw_cards(numberOfCards):
	pass