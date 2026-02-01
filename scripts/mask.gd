extends Panel
class_name Mask

var mouse_hovering: bool = false
var styleBox: StyleBoxTexture = get_theme_stylebox("panel").duplicate()
@export var index: int = 0

@onready var audio_toggle_mask: AudioStreamPlayer2D = $AudioToggleMask

func _ready() -> void:
	add_theme_stylebox_override("panel", styleBox)
	styleBox.set("texture", Master.MASK_TEXTURES[0])

func _on_mouse_entered() -> void:
	mouse_hovering = true

func _on_mouse_exited() -> void:
	mouse_hovering = false

func _input(event: InputEvent) -> void:
	var mask_len = len(Master.current_masks)
	if mouse_hovering:
		if event is InputEventMouseButton and event.is_pressed():
			if event.button_index == MOUSE_BUTTON_WHEEL_UP:
				index = (index + 1) % mask_len
				audio_toggle_mask.play()
			elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
				index = index - 1 if (index - 1) >= 0 else mask_len - 1
				audio_toggle_mask.play()
			styleBox.set("texture", Master.MASK_TEXTURES[index])
			
