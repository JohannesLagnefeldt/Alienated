extends TextureButton

@export var info_popup : Control

func _on_pressed() -> void:
	info_popup.visible = true


func _on_button_pressed() -> void:
	info_popup.visible = false
	print("aaa")
