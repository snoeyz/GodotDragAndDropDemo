class_name NativeDrawSlot extends NativeDroppableSlot

const DRAGGABLE_CARD = preload("res://scenes/native/native_draggable_card.tscn")

func _ready() -> void:
	add_card(DRAGGABLE_CARD.instantiate())

func dragged_away(card: NativeDraggableCard) -> void:
	card.randomize()
	super(card)
	add_card(DRAGGABLE_CARD.instantiate())
