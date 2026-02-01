extends Node2D
@onready var camera_2d: Camera2D = $Camera2D

var t = 0

func _process(delta: float) -> void:
	t += delta
	camera_2d.zoom = Vector2.ONE + Vector2.ONE * (t / 2)
	if(t > 2.0):
		get_tree().change_scene_to_file("res://scenes/in_game.tscn")
	
