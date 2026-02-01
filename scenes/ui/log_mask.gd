extends TextureRect

var react_correct = preload("res://assets/ui/reaction_correct.png")
var react_exists = preload("res://assets/ui/reaction_exists.png")
var react_none = preload("res://assets/ui/reaction_none.png")

@export var react_texture_rect : TextureRect
@export var guess_texture_rect : TextureRect

func set_react(react : PuzzleManager.PUZZLE_RESULT):
	if react == PuzzleManager.PUZZLE_RESULT.NONE:
		react_texture_rect.texture = react_none
	elif react == PuzzleManager.PUZZLE_RESULT.EXISTS:
		react_texture_rect.texture = react_exists
	elif react == PuzzleManager.PUZZLE_RESULT.MATCH:
		react_texture_rect.texture = react_correct

func set_guess(guess : Texture2D):
	guess_texture_rect.texture = guess
