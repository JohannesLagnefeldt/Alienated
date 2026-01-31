extends Resource
class_name MaskResource

enum SHAPE {SQUARE, ROUND, TRIANGLE, PENTAGRAM}
enum HORNS {NONE, STRAIGHT, BENT}
enum CHIP {NONE, TOP, RIGHT, LEFT}

@export var shape : SHAPE
@export var horns_shape : HORNS
@export var nbr_horns : int
@export var chip_position : CHIP
@export var nbr_chips : int
@export var mask_texture : Texture2D

func init(shape : SHAPE, horns_shape : HORNS, nbr_horns : int, chip_position : CHIP, nbr_chips : int, mask_texture : Texture2D) -> MaskResource:
	var new_mask = MaskResource.new()
	
	new_mask.shape = shape
	new_mask.horns_shape = horns_shape
	new_mask.nbr_horns = nbr_horns
	new_mask.chip_position = chip_position
	new_mask.nbr_chips = nbr_chips
	new_mask.mask_texture = mask_texture
	
	return new_mask

func equals(other : MaskResource) -> bool:
	# not tested yet. remove comment when tested
	var is_correct = other.shape == shape
	is_correct = is_correct and other.horns_shape == horns_shape
	is_correct = is_correct and other.nbr_horns == nbr_horns
	is_correct = is_correct and other.chip_position == chip_position
	is_correct = is_correct and other.nbr_chips == nbr_chips
	return is_correct
	
