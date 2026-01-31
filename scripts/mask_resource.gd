extends Resource
class_name MaskResource

enum SHAPE {SQUARE, ROUND, TRIANGLE}
enum HORNS {STRAIGHT, BENT}
enum DAMAGE {TOP, RIGHT, LEFT}

@export var shape : SHAPE
@export var horns_shape : HORNS
@export var nbr_horns : int
@export var chip_position : DAMAGE
@export var nbr_chips : int
@export var mask_texture : Texture2D

func is_equall(other : MaskResource) -> bool:
	# not tested yet. remove comment when tested
	var is_correct = other.shape == shape
	is_correct = is_correct and other.horns_shape == horns_shape
	is_correct = is_correct and other.nbr_horns == nbr_horns
	is_correct = is_correct and other.chip_position == chip_position
	is_correct = is_correct and other.nbr_chips == nbr_chips
	return is_correct
	
