class_name ButtonDroppableSlot extends PanelContainer

enum ButtonCardSlotType { DECK, HAND, DISCARD }
@export var slot_type: ButtonCardSlotType

func add_card(card: ButtonDraggableCard) -> void:
	card.dragged_away.connect(dragged_away)
	add_child(card)

func dragged_away(card: ButtonDraggableCard) -> void:
	card.dragged_away.disconnect(dragged_away)
	remove_child(card)
