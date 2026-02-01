extends Node2D

@onready var mask_reveal_animator: AnimationPlayer = $MaskRevealAnimator
@onready var reveal_mask: Sprite2D = $RevealMask

var mask_index: int = 0
var animating: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_action_pressed("reveal_mask"):
		mask_index = 0
		animating = true
		do_animation()	

func _on_mask_reveal_animator_animation_finished(anim_name: StringName) -> void:
	if anim_name == "RevealMask":
		mask_index += 1
		if mask_index >= Master.secret_masks.size():
			mask_index = 0
			animating = false
			return
		else:
			do_animation()

func do_animation():
	reveal_mask.texture = Master.secret_masks[mask_index].mask_texture
	mask_reveal_animator.play("RevealMask")
