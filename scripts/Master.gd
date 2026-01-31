extends Node

var RNG : RandomNumberGenerator = RandomNumberGenerator.new()
var MASK_TEXTURES : Array[Texture2D] = [
	preload("res://assets/Placeholder oni mask blue.png"),
	preload("res://assets/Placeholder oni mask Emerald.png"),
	preload("res://assets/Placeholder oni mask Orange.png"),
	preload("res://assets/Placeholder oni mask Orange.png"),
	preload("res://assets/Placeholder oni mask Orange.png"),
	preload("res://assets/Placeholder oni mask Orange.png"),
	preload("res://assets/Placeholder oni mask Orange.png"),
	preload("res://assets/Placeholder oni mask Orange.png"),
	preload("res://assets/Placeholder oni mask Orange.png"),
	preload("res://assets/Placeholder oni mask Red.png")
]
var MASKS : Array[MaskResource] = [
	MaskResource.new().init(
		MaskResource.SHAPE.ROUND, MaskResource.HORNS.STRAIGHT, 2, MaskResource.CHIP.RIGHT, 2, MASK_TEXTURES[0]
	), MaskResource.new().init(
		MaskResource.SHAPE.SQUARE, MaskResource.HORNS.BENT, 1, MaskResource.CHIP.TOP, 1, MASK_TEXTURES[1]
	), MaskResource.new().init(
		MaskResource.SHAPE.TRIANGLE, MaskResource.HORNS.NONE, 0, MaskResource.CHIP.LEFT, 1, MASK_TEXTURES[2]
	), MaskResource.new().init(
		MaskResource.SHAPE.ROUND, MaskResource.HORNS.BENT, 2, MaskResource.CHIP.RIGHT, 1, MASK_TEXTURES[3]
	), MaskResource.new().init(
		MaskResource.SHAPE.SQUARE, MaskResource.HORNS.STRAIGHT, 1, MaskResource.CHIP.TOP, 2, MASK_TEXTURES[4]
	), MaskResource.new().init(
		MaskResource.SHAPE.TRIANGLE, MaskResource.HORNS.BENT, 1, MaskResource.CHIP.LEFT, 2, MASK_TEXTURES[5]
	), MaskResource.new().init(
		MaskResource.SHAPE.SQUARE, MaskResource.HORNS.STRAIGHT, 2, MaskResource.CHIP.NONE, 0, MASK_TEXTURES[6]
	), MaskResource.new().init(
		MaskResource.SHAPE.ROUND, MaskResource.HORNS.NONE, 0, MaskResource.CHIP.LEFT, 1, MASK_TEXTURES[7]
	), MaskResource.new().init(
		MaskResource.SHAPE.TRIANGLE, MaskResource.HORNS.STRAIGHT, 1, MaskResource.CHIP.RIGHT, 1, MASK_TEXTURES[8]
	), MaskResource.new().init(
		MaskResource.SHAPE.PENTAGRAM, MaskResource.HORNS.BENT, 2, MaskResource.CHIP.TOP, 1, MASK_TEXTURES[9]
	)
]

var current_masks : Array[int]
var secret_masks : Array[MaskResource]
var masks_in_guess: int = 4;
var current_puzzle : int = 0
var puzzle_manager : PuzzleManager = PuzzleManager.new()

var log : Array[Array] = []

func _ready() -> void:
	current_masks = puzzle_manager.starting_masks.duplicate()
	secret_masks = puzzle_manager.puzzles_functions[current_puzzle][PuzzleManager.PUZZLE_FUNC.PULL_FUNC].call(index_to_masks(current_masks))

func index_to_masks(arr : Array[int]):
	var masks : Array[MaskResource] = []
	for i in len(arr):
		masks.append(MASKS[arr[i]])
	return masks

func try_solve(guess : Array[int]) -> Array[int]:
	return puzzle_manager.puzzles_functions[current_puzzle][PuzzleManager.PUZZLE_FUNC.VALIDATE_FUNC].call(index_to_masks(guess), secret_masks)
