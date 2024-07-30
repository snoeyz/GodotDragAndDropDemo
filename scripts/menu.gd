extends CanvasLayer

func _ready() -> void:
	FpsOverlay.show_control_type(FpsOverlay.CardControlType.NONE)

func _on_native_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/native/native_main.tscn")

func _on_button_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/button/button_main.tscn")

func _on_mouse_events_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/mouse_events/mouse_events_main.tscn")
