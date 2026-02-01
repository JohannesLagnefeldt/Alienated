extends HBoxContainer

@export
var input_masks := []
var selectors := []

@onready var audio_toggle_mask_2: AudioStreamPlayer2D = $"../../../AudioToggleMask2"
@onready var selector_box: HBoxContainer = $"../../Control2/Selector"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Signals.connect("update_masks", on_update_masks)
	on_update_masks()
	
func on_update_masks():
	for n in self.get_children():
		remove_child(n)
	for i in Master.secret_masks.size():
		var c : Panel = preload("res://scenes/alian_mask.tscn").instantiate()
		add_child(c)
		var styleBox: StyleBoxTexture = StyleBoxTexture.new()
		c.add_theme_stylebox_override("panel", styleBox)
		styleBox.set("texture", Master.secret_masks[i].mask_texture)
		input_masks.append(c)
