class_name NativeHandSlot extends NativeDroppableSlot

func _drop_data(at_position: Vector2, data: Variant) -> void:
	var card: NativeDraggableCard = data as NativeDraggableCard
	card.toggle_flip(true)
	super(at_position, data)
