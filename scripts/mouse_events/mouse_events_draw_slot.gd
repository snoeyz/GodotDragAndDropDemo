class_name MouseEventsDrawSlot extends MouseEventsDroppableSlot

const DRAGGABLE_CARD = preload("res://scenes/mouse_events/mouse_events_draggable_card.tscn")

func _ready() -> void:
	draw_card()

func draw_card() -> void:
	add_card(DRAGGABLE_CARD.instantiate())

func dragged_away(card: MouseEventsDraggableCard) -> void:
	card.randomize()
	super(card)
	draw_card()
