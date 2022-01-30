extends Node


var ind_progress = 0
var ind_progress_dirty = false
var ind_bar = null
var nat_pulse = false

var ind_pulse = false
var nat_progress = 0
var nat_progress_dirty = false
var nat_bar = null

func set_industry_progress(value):
	if value < 0 or value > 100:
		push_error("Value {pct} is not a valid percentage".format({"pct": value}))
		return
	ind_progress = value
	ind_progress_dirty = true

func set_nature_progress(value):
	if value < 0 or value > 100:
		push_error("Value {pct} is not a valid percentage".format({"pct": value}))
		return
	nat_progress = value
	nat_progress_dirty = true

func _are_progress_values_valid():
	if not ind_progress + nat_progress <= 100:
		push_error("Progress values are not valid percentages (Ind: {ind}, Nat: {nat})".format({
			"ind": ind_progress,
			"nat": nat_progress
		}))
		return false
	return true

# Called when the node enters the scene tree for the first time.
func _ready():
	ind_bar = get_node("IndustrialProgress")
	nat_bar = get_node("NatureProgress")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if nat_pulse:
		nat_bar.modulate.g = 0.1
		nat_bar.modulate.b = 0.1
	else:
		nat_bar.modulate.g = 1
		nat_bar.modulate.b = 1
	if ind_pulse:
		ind_bar.modulate.g = 0.1
		ind_bar.modulate.b = 0.1
	else:
		ind_bar.modulate.g = 1
		ind_bar.modulate.b = 1
	
	if not _are_progress_values_valid():
		return

	if ind_progress_dirty:
		ind_bar.value = ind_progress
		ind_progress_dirty = false
	
	if nat_progress_dirty:
		nat_bar.value = nat_progress
		nat_progress_dirty = false
