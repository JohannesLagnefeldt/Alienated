extends Node

signal alien_react(reaction : int)

@export var checking_masks: bool = false

@onready var good: Sprite2D = $Good
@onready var bad: Sprite2D = $Bad
@onready var almost: Sprite2D = $Almost
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var mask_container: HBoxContainer = $VBoxContainer/Control/MaskContainer

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_action_pressed("ui_accept") and not checking_masks:
		checking_masks = true
		var input_array: Array[int] = []
		for mask in mask_container.input_masks:
			input_array.append(mask.index)
		var answer = Master.try_solve(input_array)
		for i in range(answer.size()):
			mask_container.selectors[i].toggle_on(true)
			emit_signal("alien_react", answer[i])
			await get_tree().create_timer(2).timeout
			mask_container.selectors[i].toggle_on(false)
		checking_masks = false
