extends CanvasLayer
class_name OptionsMenu

@export var previus_menu : Node

@export_group("Sound")
@export var sfx_slider : HSlider
@export var music_slider : HSlider

@export_group("Graphics")
@export var fullscreen_button : Button

@export_group("Gameplay")



func _ready() -> void:
	var sfx_index = AudioServer.get_bus_index("SFX")
	sfx_slider.value = AudioServer.get_bus_volume_db(sfx_index)
	var music_index = AudioServer.get_bus_index("Music")
	music_slider.value = AudioServer.get_bus_volume_db(music_index)
	fullscreen_button.button_pressed = DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN

func set_sfx_volume(is_changed : bool):
	if is_changed:
		var sfx_index = AudioServer.get_bus_index("SFX")
		AudioServer.set_bus_volume_db(sfx_index, sfx_slider.value * -1)


func set_music_volume(is_changed : bool):
	if is_changed:
		var music_index = AudioServer.get_bus_index("Music")
		AudioServer.set_bus_volume_db(music_index, music_slider.value * -1)

func set_fullscreen(is_set_fullscreen : bool):
	if is_set_fullscreen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED) 

func go_back():
	previus_menu.visible = true
	visible = false
