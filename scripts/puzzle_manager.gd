extends Node2D
class_name PuzzleManager

@export var starting_masks : Array[int] = [0, 1]
enum PUZZLE_FUNC {PULL_FUNC, VALIDATE_FUNC, REWARD_MASK_INDEX}
@export var puzzles_functions = [
	[pull_three, match_all, 2],
	[pull_three, match_reverse, 3],
	[pull_three_no_square, more_edges, 4],
]
enum PUZZLE_RESULT {NONE, EXISTS, MATCH}

########################
###      Filters     ###
########################
func filter_nothing(_mask : MaskResource):
	return false
	
func filter_square(mask : MaskResource):
	return mask.shape == MaskResource.SHAPE.SQUARE

########################
### Secret Selectors ###
########################
func pull_random(nbr_to_pull : int, mask_pool : Array[MaskResource], filter):
	var chosen_masks : Array[MaskResource] = []
	var pool_len : int = len(mask_pool) - 1
	for i in nbr_to_pull:
		var candidate = mask_pool[Master.RNG.randi_range(0, pool_len)]
		while filter.call(candidate):
			candidate = mask_pool[Master.RNG.randi_range(0, pool_len)]			
		chosen_masks.append(candidate)
	
	return chosen_masks

# Puzzle 0, 1
func pull_three(mask_pool : Array[MaskResource]):
	return pull_random(3, mask_pool, filter_nothing)

# Puzzle 2
func pull_three_no_square(mask_pool : Array[MaskResource]):
	return pull_random(3, mask_pool, filter_square)

########################
###    Validators    ###
########################

# Puzzle 0
func match_all(guess : Array[MaskResource], secret : Array[MaskResource]):
	var result : Array[PUZZLE_RESULT] = []
	var l = len(guess)
	for m in l:
		if guess[m].equals(secret[m]):
			result.append(PUZZLE_RESULT.MATCH)
		elif secret.has(guess[m]):
			result.append(PUZZLE_RESULT.EXISTS)
		else:
			result.append(PUZZLE_RESULT.NONE)
	
	return result

# Puzzle 1
func match_reverse(guess : Array[MaskResource], secret : Array[MaskResource]):
	var result : Array[PUZZLE_RESULT] = []
	var l = len(guess)
	for m in l:
		if guess[m].equals(secret[l - 1 - m]):
			result.append(PUZZLE_RESULT.MATCH)
		elif secret.has(guess[m]):
			result.append(PUZZLE_RESULT.EXISTS)
		else:
			result.append(PUZZLE_RESULT.NONE)
	
	return result


# Puzzle 2
func more_edges(guess : Array[MaskResource], secret : Array[MaskResource]):
	var scale = [MaskResource.SHAPE.ROUND, MaskResource.SHAPE.TRIANGLE, MaskResource.SHAPE.SQUARE, MaskResource.SHAPE.PENTAGRAM]
	
	var result : Array[PUZZLE_RESULT] = []
	var l = len(guess)
	for m in l:
		var edges = scale.find(secret[m].shape)
		if guess[m].shape != scale[edges + 1]:
			result.append(PUZZLE_RESULT.MATCH)
		elif secret.has(guess[m]):
			result.append(PUZZLE_RESULT.EXISTS)
		else:
			result.append(PUZZLE_RESULT.NONE)
	
	return result
