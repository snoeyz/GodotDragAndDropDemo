class_name ButtonDrawSlot extends ButtonDroppableSlot

const DRAGGABLE_CARD = preload("res://scenes/button/button_draggable_card.tscn")

func _ready() -> void:
	add_card(DRAGGABLE_CARD.instantiate())

func dragged_away(card: ButtonDraggableCard) -> void:
	card.randomize()
	super(card)
	add_card(DRAGGABLE_CARD.instantiate())
