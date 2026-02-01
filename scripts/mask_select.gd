extends HBoxContainer
class_name MaskSelect

@export var mask_texture_rect : TextureRect
@onready var audio_toggle_mask : AudioStreamPlayer2D

var mask_index : int = 0
var mouse_hovering : bool = false

func _ready() -> void:
	mask_texture_rect = $TextureRect
	audio_toggle_mask = $AudioToggleMask
	update_texture(0)

func update_texture(index_diff : int):
	mask_index += index_diff
	if mask_index < 0:
		mask_index = len(Master.MASK_TEXTURES) - 1
	elif mask_index > len(Master.MASK_TEXTURES) - 1:
		mask_index = 0
	mask_texture_rect.texture = Master.MASK_TEXTURES[mask_index]

func _on_button_left_pressed() -> void:
	update_texture(-1)

func _on_button_right_pressed() -> void:
	update_texture(+1)
	
func _on_mouse_entered() -> void:
	mouse_hovering = true

func _on_mouse_exited() -> void:
	mouse_hovering = false

func _input(event: InputEvent) -> void:
	if mouse_hovering:
		if event is InputEventMouseButton and event.is_pressed():
			var mask_len = len(Master.current_masks)
			if event.button_index == MOUSE_BUTTON_WHEEL_UP:
				update_texture(+1)
				audio_toggle_mask.play()
			elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
				update_texture(-1)
				audio_toggle_mask.play()
