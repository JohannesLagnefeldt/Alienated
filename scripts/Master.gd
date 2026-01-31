extends Node

var MASK_TEXTURES : Array[Texture2D] = [
	preload("res://assets/Placeholder oni mask blue.png"),
	preload("res://assets/Placeholder oni mask Emerald.png"),
	preload("res://assets/Placeholder oni mask Orange.png"),
	preload("res://assets/Placeholder oni mask Red.png")
]

var current_masks : Array[int]
var secret_masks : Array[int]
var masks_in_guess: int = 4;

var log : Array[Array] = []

func _ready() -> void:
	current_masks = [0,1,2,3]
	secret_masks = [0,1,2,3]

func try_solve(guess : Array[int]) -> Vector2:
	print(guess)
	var temp = secret_masks.duplicate()
	var result : Vector2 = Vector2.ZERO
	for i : int in range(temp.size()):
		if temp[i] == guess[i]:
			temp[i] = -1
			result.x += 1
	
	for j : int in range(temp.size()):
		if temp.has(guess[j]):
			result.y += 1
	
	log.append([guess.duplicate(), result])
	return result
