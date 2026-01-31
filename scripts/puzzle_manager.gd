extends Node

var masks : Array[MaskResource] = [
	MaskResource.new().init(
		MaskResource.SHAPE.ROUND, MaskResource.HORNS.STRAIGHT, 2, MaskResource.CHIP.RIGHT, 2, Master.MASK_TEXTURES[0]
	), MaskResource.new().init(
		MaskResource.SHAPE.SQUARE, MaskResource.HORNS.BENT, 1, MaskResource.CHIP.TOP, 1, Master.MASK_TEXTURES[1]
	), MaskResource.new().init(
		MaskResource.SHAPE.TRIANGLE, MaskResource.HORNS.NONE, 0, MaskResource.CHIP.LEFT, 1, Master.MASK_TEXTURES[2]
	), MaskResource.new().init(
		MaskResource.SHAPE.ROUND, MaskResource.HORNS.BENT, 2, MaskResource.CHIP.RIGHT, 1, Master.MASK_TEXTURES[3]
	), MaskResource.new().init(
		MaskResource.SHAPE.SQUARE, MaskResource.HORNS.STRAIGHT, 1, MaskResource.CHIP.TOP, 2, Master.MASK_TEXTURES[4]
	), MaskResource.new().init(
		MaskResource.SHAPE.TRIANGLE, MaskResource.HORNS.BENT, 1, MaskResource.CHIP.LEFT, 2, Master.MASK_TEXTURES[5]
	), MaskResource.new().init(
		MaskResource.SHAPE.SQUARE, MaskResource.HORNS.STRAIGHT, 2, MaskResource.CHIP.NONE, 0, Master.MASK_TEXTURES[6]
	), MaskResource.new().init(
		MaskResource.SHAPE.ROUND, MaskResource.HORNS.NONE, 0, MaskResource.CHIP.LEFT, 1, Master.MASK_TEXTURES[7]
	), MaskResource.new().init(
		MaskResource.SHAPE.TRIANGLE, MaskResource.HORNS.STRAIGHT, 1, MaskResource.CHIP.RIGHT, 1, Master.MASK_TEXTURES[8]
	), MaskResource.new().init(
		MaskResource.SHAPE.PENTAGRAM, MaskResource.HORNS.BENT, 2, MaskResource.CHIP.TOP, 1, Master.MASK_TEXTURES[9]
	)
]

var starting_masks : Array[int] = [0, 1]
var puzzles_functions = [
	[pull_three, match_all, 2],
	[pull_three, match_reverse, 3],
	[pull_three_no_square, more_edges, 3],
]


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
	var pool_len : int = len(mask_pool)
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
	var l = len(guess)
	for m in l:
		if not guess[m].equals(secret[m]):
			return false
	
	return true

# Puzzle 1
func match_reverse(guess : Array[MaskResource], secret : Array[MaskResource]):
	var l = len(guess)
	for m in l:
		if not guess[m].equals(secret[l - 1 - m]):
			return false
	
	return true


# Puzzle 2
func more_edges(guess : Array[MaskResource], secret : Array[MaskResource]):
	var scale = [MaskResource.SHAPE.ROUND, MaskResource.SHAPE.TRIANGLE, MaskResource.SHAPE.SQUARE, MaskResource.SHAPE.PENTAGRAM]
	
	var l = len(guess)
	for m in l:
		var edges = scale.find(secret[m].shape)
		if guess[m].shape != scale[edges + 1]:
			return false
	
	return true
