class_name NativeDrawSlot extends NativeDroppableSlot

const DRAGGABLE_CARD = preload("res://scenes/native/native_draggable_card.tscn")

func _ready() -> void:
	draw_card()

func draw_card() -> void:
	add_card(DRAGGABLE_CARD.instantiate())

func dragged_away(card: NativeDraggableCard) -> void:
	card.randomize()
	super(card)
	draw_card()
