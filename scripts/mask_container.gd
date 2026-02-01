extends HBoxContainer

@export
var input_masks := []
var selectors := []

@onready var audio_toggle_mask_2: AudioStreamPlayer2D = $"../../../AudioToggleMask2"
@onready var selector_box: HBoxContainer = $"../Selector"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	
	#for n in self.get_children():
	#	remove_child(n)
	for i in Master.secret_masks.size():
		var c = preload("res://scenes/mask.tscn").instantiate()
		add_child(c)
		input_masks.append(c)
	for j in get_children():
		var selector = preload("res://scenes/Selector.tscn").instantiate()
		selector_box.add_child(selector)
		selector.toggle_on(false)
		selectors.append(selector)
