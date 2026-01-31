extends HBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for n in self.get_children():
		remove_child(n)
	for i in Master.masks_in_guess:
		add_child(preload("uid://b3xqkba08wweq").instantiate())
		print("made mask")
	pass # Replace with function body.
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
