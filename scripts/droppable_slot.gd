class_name DroppableSlot extends PanelContainer

enum CardSlotType { DECK, HAND, DISCARD }
@export var slot_type: CardSlotType

func dragged_away(card: DraggableCard) -> void:
	return remove_child(card)

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	if data is DraggableCard:
		match (data as DraggableCard).card_source:
			CardSlotType.DECK:
				return slot_type != CardSlotType.DISCARD
			CardSlotType.HAND:
				return slot_type != CardSlotType.DECK
			CardSlotType.DISCARD:
				return false
	return false

func _drop_data(at_position: Vector2, data: Variant) -> void:
	var card: DraggableCard = data as DraggableCard
	(card.get_parent() as DroppableSlot).dragged_away(card)
	card.card_source = slot_type
	add_child(card)
