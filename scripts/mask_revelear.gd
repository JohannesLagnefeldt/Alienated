extends Node2D

@onready var mask_reveal_animator: AnimationPlayer = $MaskRevealAnimator
@onready var reveal_mask: Sprite2D = $RevealMask


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_action_pressed("reveal_mask"):
		var i = randi_range(0, len(Master.secret_masks) - 1)
		reveal_mask.texture = Master.secret_masks[i].mask_texture
		mask_reveal_animator.play("RevealMask")
