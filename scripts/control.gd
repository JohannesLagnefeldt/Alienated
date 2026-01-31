extends Panel

var mouse_over = false
var styleBox: StyleBoxFlat = get_theme_stylebox("panel")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _on_mouse_entered() -> void:
	mouse_over = true

func _on_mouse_exited() -> void:
	mouse_over = false

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed() and mouse_over:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			styleBox.set("bg_color", Color(1.0, 0.0, 0.0))
			print("up mouse wheel")
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			styleBox.set("bg_color", Color(0.0, 0.0, 1.0))
			print("down mouse wheel")
		
