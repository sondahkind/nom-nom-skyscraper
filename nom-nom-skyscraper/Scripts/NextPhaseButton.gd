extends Button

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_NextPhaseButton_pressed():
	print("button was pressed")
	var game_logic_node = get_node("/root/Node2D/GameLogic")
	game_logic_node.next_phase()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
