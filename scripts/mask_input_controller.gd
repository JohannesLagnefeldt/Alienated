extends Node

signal alien_react(reaction : int)

@onready var good: Sprite2D = $Good
@onready var bad: Sprite2D = $Bad
@onready var almost: Sprite2D = $Almost
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var mask_container: HBoxContainer = $VBoxContainer/Control/MaskContainer

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_action_pressed("ui_accept"):
		var awnser = Master.try_solve(mask_container.input_masks)
		for i in awnser:
			mask_container.selectors[i].toggle_on(true)
			emit_signal("alien_react", i)
			await get_tree().create_timer(2).timeout
			mask_container.selectors[i].toggle_on(false)
