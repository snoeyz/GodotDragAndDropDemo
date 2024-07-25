class_name Overlay extends CanvasLayer

@export var keep_framerate_history_length: int = 150

@onready var fps_value: Label = $MarginContainer/PanelContainer/MarginContainer/VBoxContainer/GridContainer/FPSValue
@onready var toggle_v_sync_button: Button = $MarginContainer/PanelContainer/MarginContainer/VBoxContainer/ToggleVSyncButton

var framerate_history: Array[float]

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
