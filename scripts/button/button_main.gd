class_name ButtonMain extends Control

@onready var card_1: ButtonDroppableSlot = $Hand/Card1
@onready var card_2: ButtonDroppableSlot = $Hand/Card2
@onready var card_3: ButtonDroppableSlot = $Hand/Card3
@onready var card_4: ButtonDroppableSlot = $Hand/Card4
@onready var card_5: ButtonDroppableSlot = $Hand/Card5
@onready var card_6: ButtonDroppableSlot = $Hand/Card6
@onready var card_7: ButtonDroppableSlot = $Hand/Card7
@onready var discard_slot: ButtonDroppableSlot = $DiscardAndDraw/DiscardSlot
@onready var draw_slot: ButtonDrawSlot = $DiscardAndDraw/DrawSlot

@onready var slot_list: Array[ButtonDroppableSlot] = [card_1, card_2, card_3, card_4, card_5, card_6, card_7, discard_slot, draw_slot]

func _ready() -> void:
	ButtonEventBus.card_dropped.connect(_on_card_dropped)

func _on_card_dropped(card: ButtonDraggableCard) -> void:
	var slot: ButtonDroppableSlot = get_slot_at_pos(get_global_mouse_position())
	if slot:
		if not card.can_move_to_slot(slot):
			card.revert_pos()
		else:
			card.move_to_slot(slot)
	else:
		card.revert_pos()

func get_slot_at_pos(pos: Vector2) -> ButtonDroppableSlot:
	for slot in slot_list:
		if slot.get_global_rect().has_point(pos):
			return slot
	return null
