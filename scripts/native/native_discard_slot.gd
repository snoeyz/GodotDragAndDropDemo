class_name NativeDiscardSlot extends NativeDroppableSlot

func _drop_data(at_position: Vector2, data: Variant) -> void:
	var card: NativeDraggableCard = data as NativeDraggableCard
	card.mouse_filter = Control.MOUSE_FILTER_PASS
	super(at_position, data)
