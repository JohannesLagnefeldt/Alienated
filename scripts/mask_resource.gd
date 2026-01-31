extends Resource
class_name MaskResource

enum SHAPE {SQUARE, ROUND, TRIANGLE}
enum HORNS {STRAIGHT, BENT, SQIGGLY}
enum DAMAGE {NONE, CHIPS, CRACKS}

@export var shape : SHAPE
@export var horns : HORNS
@export var damage : DAMAGE

func is_equall(other : MaskResource) -> bool:
	return other.damage == self.damage and other.horns == self.horns and other.shape == self.shape
	
