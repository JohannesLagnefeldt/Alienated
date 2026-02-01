extends Node2D

@onready var pda_ui: PDA_UI = %PDAUI
var checking_masks: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pda_ui.clear_log()
	pda_ui.set_mask_amount(Master.secret_masks.size())
	pda_ui.add_log(getTextures(Master.secret_masks))

func getTexturesFromIndexes(mask_resources: Array[int]):
	var mask_textures : Array[Texture2D] = []
	for mask in mask_resources:
		mask_textures.append(Master.MASK_TEXTURES[mask])
	return mask_textures
	
func getTextures(mask_resources: Array[MaskResource]):
	var mask_textures : Array[Texture2D] = []
	for mask in mask_resources:
		mask_textures.append(mask.mask_texture)
	return mask_textures

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_action_pressed("ui_accept") and not checking_masks:
		checking_masks = true
		var input_array: Array[int] = pda_ui.get_player_guess()
		var answer = Master.try_solve(input_array)
		pda_ui.evaluate_log(answer, getTexturesFromIndexes(input_array))
		var answer_correct : bool = true
		for i in range(answer.size()):
			#mask_container.selectors[i].toggle_on(true)
			Signals.emit_signal("alien_react", answer[i])
			if answer[i] != PuzzleManager.PUZZLE_RESULT.MATCH:
				answer_correct = false
			await get_tree().create_timer(1).timeout
			#mask_container.selectors[i].toggle_on(false)
		if answer_correct:
			pda_ui.set_light(Master.correct_guesses, true)
			Master.correct_guesses += 1
		else:
			Master.correct_guesses = 0
			pda_ui.turn_off_lights()
			pda_ui.set_light(Master.correct_guesses, true)
		checking_masks = false
		print("Correct Guesses: " + str(Master.correct_guesses))
		Master.generate_masks()
		
		pda_ui.add_log(getTextures(Master.secret_masks))
		Signals.emit_signal("update_masks")
		Signals.emit_signal("point_change", Master.correct_guesses)
		if Master.correct_guesses == 3:
			pda_ui.turn_off_lights()
			pda_ui.clear_log()
			Signals.emit_signal("level_win")
			Master.next_level()
			pda_ui.set_mask_amount(len(Master.secret_masks))
			Signals.emit_signal("alien_change")
			pda_ui.add_log(getTextures(Master.secret_masks))
		else:
			Signals.emit_signal("show_masks")
