class_name DiscardSlot extends DroppableSlot

func _drop_data(at_position: Vector2, data: Variant) -> void:
	var card: DraggableCard = data as DraggableCard
	card.mouse_filter = Control.MOUSE_FILTER_PASS
	super(at_position, data)
