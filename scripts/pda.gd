extends Control
class_name PDA_UI

var mask_selector = preload("res://scenes/ui/mask_select.tscn")

@export var guess_container : Control

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
