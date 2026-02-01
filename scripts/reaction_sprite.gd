extends Node2D

@onready var animated_sprite_2d: AnimatedSprite2D = $Node2D/AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $Node2D/AnimatedSprite2D/AnimationPlayer
@onready var ui: Control = %"UI"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Signals.connect("alien_react", _on_alien_react)
	
func _on_alien_react(reaction: int) -> void:
	animated_sprite_2d.play(["Bad", "Questioning", "Good"][reaction])
	animation_player.play("ReactionAnimation")
