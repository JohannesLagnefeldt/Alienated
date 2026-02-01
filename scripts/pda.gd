extends Control
class_name PDA_UI

var mask_selector = preload("res://scenes/ui/mask_select.tscn")
var log_record = preload("res://scenes/ui/log_record.tscn")
var log_mask = preload("res://scenes/ui/log_mask.tscn")
var light_correct = preload("res://assets/ui/Green Button.png")
var light_yellow = preload("res://assets/ui/Yellow Light.png")

@export var guess_container : Control
@export var log_container : Control
@export var light_container : Control

func set_mask_amount(amount : int):
	for c in guess_container.get_children():
		guess_container.remove_child(c)
	
	for c in range(0, amount):
		guess_container.add_child(mask_selector.instantiate())

func get_player_guess():
	var player_guess : Array[int] = []
	
	var guess_childern = guess_container.get_children()
	for c : MaskSelect in guess_childern:
		player_guess.append(c.mask_index)
	
	return player_guess

func clear_log():
	for c in log_container.get_children():
		log_container.remove_child(c)

func add_log(masks : Array[Texture2D]):
	var new_record = log_record.instantiate()
	for c in new_record.get_children():
		new_record.remove_child(c)
	for m in masks:
		var new_mask = log_mask.instantiate()
		new_mask.texture = m
		new_record.add_child(new_mask)
	log_container.add_child(new_record)
	clear_last_log()
	
func clear_last_log():
	if (len(log_container.get_children()) >= 4):
		log_container.remove_child(log_container.get_children()[0])

func evaluate_log(mask_results : Array[PuzzleManager.PUZZLE_RESULT], guesses : Array[Texture2D]):
	var last_log = log_container.get_child(log_container.get_child_count() - 1)
	for c in last_log.get_child_count():
		var child = last_log.get_child(c)
		child.set_react(mask_results[c])
		child.set_guess(guesses[c])

func set_light(index : int, state : bool):
	var light_to_update = light_container.get_child(index)
	if state:
		light_to_update.texture = light_correct
	else:
		light_to_update.texture = light_yellow
		
func turn_off_lights():
	for i in 3:
		set_light(i, false)
