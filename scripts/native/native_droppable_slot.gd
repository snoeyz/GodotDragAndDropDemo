class_name NativeDroppableSlot extends PanelContainer

enum NativeCardSlotType { DECK, HAND, DISCARD }
@export var slot_type: NativeCardSlotType

func dragged_away(card: NativeDraggableCard) -> void:
	card.dragged_away.disconnect(dragged_away)
	remove_child(card)

func add_card(card: NativeDraggableCard) -> void:
	card.dragged_away.connect(dragged_away)
	add_child(card)

func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
	if data is NativeDraggableCard:
		match (data as NativeDraggableCard).card_source:
			NativeCardSlotType.DECK:
				return slot_type != NativeCardSlotType.DISCARD
			NativeCardSlotType.HAND:
				return slot_type != NativeCardSlotType.DECK
			NativeCardSlotType.DISCARD:
				return false
	return false

func _drop_data(_at_position: Vector2, data: Variant) -> void:
	var card: NativeDraggableCard = data as NativeDraggableCard
	card.dragged_away.emit(card)
	card.card_source = slot_type
	add_card(card)
