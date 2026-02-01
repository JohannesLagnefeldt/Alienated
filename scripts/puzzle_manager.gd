extends Node2D
class_name PuzzleManager

@export var starting_masks : Array[int] = [0, 1]
enum PUZZLE_FUNC {PULL_FUNC, VALIDATE_FUNC, REWARD_MASK_INDEX}
@export var puzzles_functions = [
	[pull_three, match_all, 2],
	[pull_three, match_reverse, 3],
	[pull_three_no_square, more_edges, 4],
	[pull_four, horn_sum_to_two, 5],
	[pull_four_with_horns, same_horn_diff_shape, 6],
	[pull_three_with_horns, majority_horn_shape, 7]
]
enum PUZZLE_RESULT {NONE, EXISTS, MATCH}

########################
###      Filters     ###
########################
func filter_nothing(_mask : MaskResource):
	return false
	
func filter_square(mask : MaskResource):
	return mask.shape == MaskResource.SHAPE.SQUARE

func filter_no_horn(mask : MaskResource):
	return mask.horns_shape == MaskResource.HORNS.NONE

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

# Puzzle 3
func pull_four(mask_pool : Array[MaskResource]):
	return pull_random(4, mask_pool, filter_nothing)
	
# Puzzle 4
func pull_four_with_horns(mask_pool : Array[MaskResource]):
	return pull_random(4, mask_pool, filter_no_horn)
	
# Puzzle 5
func pull_three_with_horns(mask_pool : Array[MaskResource]):
	return pull_random(3, mask_pool, filter_no_horn)

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



# Puzzle 3
func single_horn_sum_to_two(guess_mask : MaskResource, secret_mask : MaskResource):
	if guess_mask.horns_shape != secret_mask.horns_shape:
		return false
	return (guess_mask.nbr_horns + secret_mask.nbr_horns) == 2 
func horn_sum_to_two(guess : Array[MaskResource], secret : Array[MaskResource]):
	var result : Array[PUZZLE_RESULT] = []
	var l = len(guess)
	for m in l:
		if single_horn_sum_to_two(guess[m], secret[m]):
			result.append(PUZZLE_RESULT.MATCH)
		else:
			var found = false
			for i in l:
				if single_horn_sum_to_two(guess[i], secret[i]):
					found = true
			if found:
				result.append(PUZZLE_RESULT.EXISTS)
			else:
				result.append(PUZZLE_RESULT.NONE)
	
	return result

# Puzzle 4
func single_same_horn_diff_shape(guess_mask : MaskResource, secret_mask : MaskResource):
	return guess_mask.horns_shape == secret_mask.horns_shape and guess_mask.shape != secret_mask.shape
func same_horn_diff_shape(guess : Array[MaskResource], secret : Array[MaskResource]):
	var result : Array[PUZZLE_RESULT] = []
	var l = len(guess)
	for m in l:
		if single_same_horn_diff_shape(guess[m], secret[m]):
			result.append(PUZZLE_RESULT.MATCH)
		else:
			var found = false
			for i in l:
				if single_same_horn_diff_shape(guess[i], secret[i]):
					found = true
			if found:
				result.append(PUZZLE_RESULT.EXISTS)
			else:
				result.append(PUZZLE_RESULT.NONE)
	
	return result

# Puzzle 5
func majority_horn_shape(guess : Array[MaskResource], secret : Array[MaskResource]):
	var result : Array[PUZZLE_RESULT] = []
	var l = len(guess)
	var stright_count = 0
	var curved_count = 0
	for m in l:
		if secret[m].horns_shape == MaskResource.HORNS.STRAIGHT:
			stright_count += 1
		else:
			curved_count += 1
	
	var horn_shape = MaskResource.HORNS.STRAIGHT
	if curved_count > stright_count:
		horn_shape = MaskResource.HORNS.BENT
	for m in l:
		if guess[m].horns_shape == horn_shape:
			result.append(PUZZLE_RESULT.MATCH)
		else:
			result.append(PUZZLE_RESULT.NONE)
	
	return result
