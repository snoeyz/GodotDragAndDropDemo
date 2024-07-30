class_name MouseEventsDraggableCard extends Control

signal dragged_away(card: MouseEventsDraggableCard)

const TWEEN_TIME = 0.25

enum MouseEventsCardRank { ACE, ONE, TWO, THREE, FOUR, FIVE, SIX, SEVEN, EIGHT, NINE, TEN, JACK, QUEEN, KING }
enum MouseEventsCardSuit { HEART, SPADE, DIAMOND, CLUB }

var mouse_offset: Vector2
var is_being_dragged: bool
var dragged_from_pos: Vector2

@export var card_source: MouseEventsDroppableSlot.MouseEventsCardSlotType = MouseEventsDroppableSlot.MouseEventsCardSlotType.DECK
@export var card_rank: MouseEventsCardRank:
	set(value):
		card_rank = value
		update_card_value()
@export var card_suit: MouseEventsCardSuit:
	set(value):
		card_suit = value
		update_card_value()

@onready var texture_rect: TextureRect = $TextureRect
@onready var card_face: Panel = $CardFace
@onready var value_label: Label = $CardFace/ValueLabel
@onready var sprite_2d: Sprite2D = $CardFace/Sprite2D

func _init() -> void:
	FpsOverlay.card_count += 1

func get_preview() -> Control:
	if card_face.visible:
		return card_face.duplicate()
	return texture_rect.duplicate()

func randomize() -> void:
	card_rank = MouseEventsCardRank.values().pick_random()
	card_suit = MouseEventsCardSuit.values().pick_random()

func toggle_flip(show_face: bool) -> void:
	card_face.visible = show_face

func update_card_value() -> void:
	var card_rank_value: String = ["A", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K"][card_rank]
	value_label.text = "%s" % card_rank_value
	value_label.modulate = Color.RED if card_suit == 1 or card_suit == 2 else Color.BLACK
	sprite_2d.frame = card_suit
	# offset sprites due to extra border around image
	sprite_2d.offset.y = -64 if card_suit < 2 else 0

func _process(_delta: float) -> void:
	if is_being_dragged:
		global_position = get_global_mouse_position() - mouse_offset

func _on_mouse_button_down() -> void:
	mouse_offset = get_local_mouse_position()
	dragged_from_pos = global_position
	z_index += 1
	is_being_dragged = true

func _on_mouse_button_up() -> void:
	MouseEventsEventBus.card_dropped.emit(self)
	z_index -= 1
	is_being_dragged = false

func revert_pos() -> void:
	move_to_pos(dragged_from_pos)

func tween_pos_done() -> void:
	z_index -= 1

func can_move_to_slot(slot: MouseEventsDroppableSlot) -> bool:
	match slot.slot_type:
		MouseEventsDroppableSlot.MouseEventsCardSlotType.DECK:
			return false
		MouseEventsDroppableSlot.MouseEventsCardSlotType.HAND:
			return slot.get_child_count() == 0 and card_source != MouseEventsDroppableSlot.MouseEventsCardSlotType.DISCARD
		MouseEventsDroppableSlot.MouseEventsCardSlotType.DISCARD:
			return card_source == MouseEventsDroppableSlot.MouseEventsCardSlotType.HAND
	return false

func move_to_pos(pos: Vector2) -> void:
	z_index += 1
	var tween: Tween = get_tree().create_tween()
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "global_position", pos, TWEEN_TIME)
	tween.tween_callback(tween_pos_done)

func move_to_slot(slot: MouseEventsDroppableSlot) -> void:
	var old_pos: Vector2 = global_position
	dragged_away.emit(self)
	card_source = slot.slot_type
	toggle_flip(slot.slot_type != MouseEventsDroppableSlot.MouseEventsCardSlotType.DECK)
	slot.add_card(self)
	set_deferred("global_position", old_pos)
	call_deferred("move_to_pos", slot.global_position)


func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		var mouse_event: InputEventMouseButton = event as InputEventMouseButton
		if mouse_event.button_index == 1:
			if mouse_event.button_mask == 1:
				_on_mouse_button_down()
			else:
				_on_mouse_button_up()
