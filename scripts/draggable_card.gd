class_name DraggableCard extends Control

enum CardRank { ACE, ONE, TWO, THREE, FOUR, FIVE, SIX, SEVEN, EIGHT, NINE, TEN, JACK, QUEEN, KING }
enum CardSuit { HEART, SPADE, DIAMOND, CLUB }

@export var card_source: DroppableSlot.CardSlotType = DroppableSlot.CardSlotType.DECK
@export var card_rank: CardRank:
	set(value):
		card_rank = value
		update_card_value()
@export var card_suit: CardSuit:
	set(value):
		card_suit = value
		update_card_value()

@onready var texture_rect: TextureRect = $TextureRect
@onready var card_face: ColorRect = $CardFace
@onready var value_label: Label = $CardFace/ValueLabel

func get_preview() -> Control:
	if card_face.visible:
		return card_face.duplicate()
	return texture_rect.duplicate()

func _get_drag_data(at_position: Vector2) -> Variant:
	set_drag_preview(get_preview())
	return self

func randomize() -> void:
	card_rank = CardRank.values().pick_random()
	card_suit = CardSuit.values().pick_random()

func toggle_flip(show_face: bool) -> void:
	card_face.visible = show_face

func update_card_value() -> void:
	var card_rank_value: String = ["A", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K"][card_rank]
	var card_suit_value: String = ["♥", "♠", "♦", "♣"][card_suit]
	value_label.text = "%s%s" % [card_rank_value, card_suit_value]
