class_name NativeDraggableCard extends Control

signal dragged_away(card: NativeDraggableCard)

enum NativeCardRank { ACE, ONE, TWO, THREE, FOUR, FIVE, SIX, SEVEN, EIGHT, NINE, TEN, JACK, QUEEN, KING }
enum NativeCardSuit { CLUB, DIAMOND, HEART, SPADE }

@export var card_source: NativeDroppableSlot.NativeCardSlotType = NativeDroppableSlot.NativeCardSlotType.DECK
@export var card_rank: NativeCardRank:
	set(value):
		card_rank = value
		update_card_value()
@export var card_suit: NativeCardSuit:
	set(value):
		card_suit = value
		update_card_value()

@onready var texture_rect: TextureRect = $TextureRect
@onready var card_face: Panel = $CardFace
@onready var value_label: Label = $CardFace/ValueLabel
@onready var sprite_2d: Sprite2D = $CardFace/Sprite2D

func get_preview() -> Control:
	if card_face.visible:
		return card_face.duplicate()
	return texture_rect.duplicate()

func _get_drag_data(_at_position: Vector2) -> Variant:
	set_drag_preview(get_preview())
	return self

func randomize() -> void:
	card_rank = NativeCardRank.values().pick_random()
	card_suit = NativeCardSuit.values().pick_random()

func toggle_flip(show_face: bool) -> void:
	card_face.visible = show_face

func update_card_value() -> void:
	var card_rank_value: String = ["A", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K"][card_rank]
	value_label.text = "%s" % card_rank_value
	value_label.modulate = Color.RED if card_suit == 1 or card_suit == 2 else Color.BLACK
	sprite_2d.frame = card_suit
	# offset sprites due to extra border around image
	sprite_2d.offset.y = -64 if card_suit < 2 else 0
