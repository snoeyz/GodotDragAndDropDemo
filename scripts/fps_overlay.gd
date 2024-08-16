class_name Overlay extends CanvasLayer

@export var keep_framerate_history_length: int = 150

@onready var fps_value: Label = $MarginContainer/PanelContainer/MarginContainer/VBoxContainer/GridContainer/FPSValue
@onready var toggle_v_sync_button: Button = $MarginContainer/PanelContainer/MarginContainer/VBoxContainer/ToggleVSyncButton
@onready var card_count_value: Label = $MarginContainer/PanelContainer/MarginContainer/VBoxContainer/GridContainer/CardCountValue
@onready var control_type_label: Label = $MarginContainer/PanelContainer/MarginContainer/VBoxContainer/ControlTypeLabel

enum CardControlType { NONE, BUTTON, MOUSEEVENTS, NATIVE }

var framerate_history: Array[float]
var card_count: int:
	set(value):
		card_count = value
		if card_count_value:
			card_count_value.text = str(value)

func _ready() -> void:
	toggle_vsync(DisplayServer.window_get_vsync_mode() != DisplayServer.VSYNC_DISABLED)

func toggle_vsync(enabled: bool) -> void:
	toggle_v_sync_button.button_pressed = enabled
	toggle_v_sync_button.text = "VSync: %s" % ("ON " if enabled else "OFF")
	DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED if enabled else DisplayServer.VSYNC_DISABLED)

func _process(_delta: float) -> void:
	fps_value.text = str(Engine.get_frames_per_second())

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().change_scene_to_file("res://scenes/menu.tscn")

func show_control_type(control_type: CardControlType) -> void:
	match control_type:
		CardControlType.NONE:
			control_type_label.visible = false
		CardControlType.BUTTON:
			control_type_label.visible = true
			control_type_label.text = "Button-Based Cards"
		CardControlType.MOUSEEVENTS:
			control_type_label.visible = true
			control_type_label.text = "Mouse Event Cards"
		CardControlType.NATIVE:
			control_type_label.visible = true
			control_type_label.text = "Native Drag and Drop"
			


func _on_main_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
