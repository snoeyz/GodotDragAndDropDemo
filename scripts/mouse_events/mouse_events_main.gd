class_name MouseEventsMain extends Control

@onready var card_1: MouseEventsDroppableSlot = $Hand/Card1
@onready var card_2: MouseEventsDroppableSlot = $Hand/Card2
@onready var card_3: MouseEventsDroppableSlot = $Hand/Card3
@onready var card_4: MouseEventsDroppableSlot = $Hand/Card4
@onready var card_5: MouseEventsDroppableSlot = $Hand/Card5
@onready var card_6: MouseEventsDroppableSlot = $Hand/Card6
@onready var card_7: MouseEventsDroppableSlot = $Hand/Card7
@onready var discard_slot: MouseEventsDroppableSlot = $DiscardAndDraw/DiscardSlot
@onready var draw_slot: MouseEventsDrawSlot = $DiscardAndDraw/DrawSlot

@onready var slot_list: Array[MouseEventsDroppableSlot] = [card_1, card_2, card_3, card_4, card_5, card_6, card_7, discard_slot, draw_slot]

func _init() -> void:
	FpsOverlay.card_count = 0
	FpsOverlay.show_control_type(FpsOverlay.CardControlType.MOUSEEVENTS)

func _ready() -> void:
	MouseEventsEventBus.card_dropped.connect(_on_card_dropped)

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_up"):
		for _i in 100:
			$DiscardAndDraw/DrawSlot.draw_card()

func _on_card_dropped(card: MouseEventsDraggableCard) -> void:
	var slot: MouseEventsDroppableSlot = get_slot_at_pos(get_global_mouse_position())
	if slot:
		if not card.can_move_to_slot(slot):
			card.revert_pos()
		else:
			card.move_to_slot(slot)
	else:
		card.revert_pos()

func get_slot_at_pos(pos: Vector2) -> MouseEventsDroppableSlot:
	for slot in slot_list:
		if slot.get_global_rect().has_point(pos):
			return slot
	return null
