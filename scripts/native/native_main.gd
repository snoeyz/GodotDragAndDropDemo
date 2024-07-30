extends Control

func _init() -> void:
	FpsOverlay.card_count = 0
	FpsOverlay.show_control_type(FpsOverlay.CardControlType.NATIVE)

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_up"):
		for _i in 100:
			$DiscardAndDraw/DrawSlot.draw_card()
