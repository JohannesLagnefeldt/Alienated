extends Node

@export var checking_masks: bool = false

@onready var good: Sprite2D = $Good
@onready var bad: Sprite2D = $Bad
@onready var almost: Sprite2D = $Almost
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var mask_container: HBoxContainer = $VBoxContainer/Control2/MaskContainer

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_action_pressed("ui_accept") and not checking_masks:
		checking_masks = true
		var input_array: Array[int] = []
		for mask in mask_container.input_masks:
			input_array.append(mask.index)
		var answer = Master.try_solve(input_array)
		var answer_correct : bool = true
		for i in range(answer.size()):
			mask_container.selectors[i].toggle_on(true)
			Signals.emit_signal("alien_react", answer[i])
			if answer[i] != PuzzleManager.PUZZLE_RESULT.MATCH:
				answer_correct = false
			await get_tree().create_timer(1).timeout
			mask_container.selectors[i].toggle_on(false)
		if answer_correct:
			Master.correct_guesses += 1
		else:
			Master.correct_guesses = 0
		checking_masks = false
		print("Correct Guesses: " + str(Master.correct_guesses))
		
		
		Master.generate_masks()
		Signals.emit_signal("update_masks")
		Signals.emit_signal("point_change", Master.correct_guesses)
		if Master.correct_guesses == 3:
			Signals.emit_signal("level_win")
			Master.next_level()
			
