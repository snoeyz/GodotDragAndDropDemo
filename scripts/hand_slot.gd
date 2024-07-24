class_name HandSlot extends DroppableSlot

func _drop_data(at_position: Vector2, data: Variant) -> void:
	var card: DraggableCard = data as DraggableCard
	card.toggle_flip(true)
	super(at_position, data)
