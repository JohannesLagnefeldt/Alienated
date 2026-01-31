extends HBoxContainer

@export
var input_masks = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for n in self.get_children():
		remove_child(n)
	for i in Master.masks_in_guess:
		var c = preload("uid://b3xqkba08wweq").instantiate()
		add_child(c)
		input_masks.append(c)
	pass # Replace with function body.
	

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_pressed():
		if event.keycode == KEY_ENTER:
			var guess : Array[int]
			for m in input_masks:
				guess.append(m.index)
			print(Master.try_solve(guess))
