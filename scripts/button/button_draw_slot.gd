class_name ButtonDrawSlot extends ButtonDroppableSlot

const DRAGGABLE_CARD = preload("res://scenes/button/button_draggable_card.tscn")

func _ready() -> void:
	draw_card()

func draw_card() -> void:
	add_card(DRAGGABLE_CARD.instantiate())

func dragged_away(card: ButtonDraggableCard) -> void:
	card.randomize()
	super(card)
	draw_card()
