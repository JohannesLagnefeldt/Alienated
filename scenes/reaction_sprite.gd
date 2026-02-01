extends Node2D

@onready var animated_sprite_2d: AnimatedSprite2D = $Node2D/AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $Node2D/AnimatedSprite2D/AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_action_pressed("show_reaction"):
		var i = randi_range(0, 2)
		["Bad", "Questioning", "Good"]
		animated_sprite_2d.play(["Bad", "Questioning", "Good"][i])
		animation_player.play("ReactionAnimation")
