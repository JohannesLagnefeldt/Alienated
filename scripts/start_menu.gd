extends Control

@onready var options_menu: CanvasLayer = $OptionsMenu
@onready var credits_menu: CanvasLayer = $CreditsMenu
@onready var check_button: CheckButton = $OptionsMenu/CenterContainer/hBox/VBoxContainer2/CheckButton
@onready var check_button_2: CheckButton = $OptionsMenu/CenterContainer/hBox/VBoxContainer2/CheckButton2
@onready var check_button_3: CheckButton = $OptionsMenu/CenterContainer/hBox/VBoxContainer2/CheckButton3
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var player_space_ship: Sprite2D = $PlayerSpaceShip
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var can_press := true

func _ready() -> void:
	var sfx_index = AudioServer.get_bus_index("SFX")
	check_button.button_pressed = bool(AudioServer.get_bus_volume_linear(sfx_index))
	var music_index = AudioServer.get_bus_index("Music")
	check_button_2.button_pressed = bool(AudioServer.get_bus_volume_linear(music_index))
	check_button_3.button_pressed = DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN
	animation_player.play("ShipIdle")

func _on_play_pressed() -> void:
	if can_press:
		animation_player.pause()
		audio_stream_player.play()
		can_press = false
		animation_player.play("ShipCrashing")


func _on_options_pressed() -> void:
	if can_press:
		audio_stream_player.play()
		options_menu.visible = true


func _on_credits_pressed() -> void:
	if can_press:
		audio_stream_player.play()
		credits_menu.visible = true

func _on_exit_pressed() -> void:
	if can_press:
		audio_stream_player.play()
		get_tree().quit()


func _on_check_button_toggled(toggled_on: bool) -> void:
	audio_stream_player.play()
	var music_index = AudioServer.get_bus_index("Music")
	AudioServer.set_bus_volume_linear(music_index, int(toggled_on))


func _on_check_button_2_toggled(toggled_on: bool) -> void:
	audio_stream_player.play()
	var sfx_index = AudioServer.get_bus_index("SFX")
	AudioServer.set_bus_volume_linear(sfx_index, int(toggled_on))

func _on_check_button_3_toggled(toggled_on: bool) -> void:
	audio_stream_player.play()
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		
func _on_button_button_down() -> void:
	audio_stream_player.play()
	options_menu.visible = false

func _on_play_mouse_entered() -> void:
	if can_press:
		var new_texture : Texture2D = load("res://assets/sprites/MenuRocket/Rocket menu crsh hover.png")
		player_space_ship.texture = new_texture

func _on_play_mouse_exited() -> void:
	if can_press:
		var new_texture : Texture2D = load("res://assets/sprites/MenuRocket/Rocket menu.png")
		player_space_ship.texture = new_texture

func _on_options_mouse_entered() -> void:
	if can_press:
		var new_texture : Texture2D = load("res://assets/sprites/MenuRocket/Rocket menu option hover.png")
		player_space_ship.texture = new_texture

func _on_options_mouse_exited() -> void:
	if can_press:
		var new_texture : Texture2D = load("res://assets/sprites/MenuRocket/Rocket menu.png")
		player_space_ship.texture = new_texture

func _on_credits_back_pressed() -> void:
	audio_stream_player.play()
	credits_menu.visible = false

func switch_scene():
	get_tree().change_scene_to_file("res://scenes/UI.tscn")
