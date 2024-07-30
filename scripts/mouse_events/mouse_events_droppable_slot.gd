class_name MouseEventsDroppableSlot extends PanelContainer

enum MouseEventsCardSlotType { DECK, HAND, DISCARD }
@export var slot_type: MouseEventsCardSlotType

func add_card(card: MouseEventsDraggableCard) -> void:
	card.dragged_away.connect(dragged_away)
	add_child(card)

func dragged_away(card: MouseEventsDraggableCard) -> void:
	card.dragged_away.disconnect(dragged_away)
	remove_child(card)
