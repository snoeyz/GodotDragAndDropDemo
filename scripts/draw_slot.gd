class_name DrawSlot extends DroppableSlot

const DRAGGABLE_CARD = preload("res://scenes/draggable_card.tscn")

func dragged_away(card: DraggableCard) -> void:
	card.randomize()
	super(card)
	add_child(DRAGGABLE_CARD.instantiate())
