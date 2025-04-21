extends Node2D
class_name Movable

var _active := false
var _being_hovered := false
var _impulse_origin := Vector2.ZERO
var _impulse := Vector2.ZERO

@export var _range := 400:
	set(value):
		_range = value
		_min_range = Vector2(-_range, -_range)
		_max_range = Vector2(+_range, +_range)
var _min_range := Vector2(-_range, -_range)
var _max_range := Vector2(+_range, +_range)

@onready var _target: RigidBody2D = get_parent()

func _ready():
	_target.input_pickable = true
	_target.mouse_entered.connect(_hover)
	_target.mouse_exited .connect(_unhover)
	
func _hover() -> void:
	_being_hovered = true

func _unhover() -> void:
	_being_hovered = false

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		_impulse = event.position - _impulse_origin
		_impulse = _impulse.clamp(_min_range, _max_range)
	elif event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				_impulse_origin = event.position
			elif _target.get_contact_count() > 0:
				_apply_impulse()

func _apply_impulse():
	_target.apply_impulse(_impulse * -1 * _target.mass)
	_impulse_origin = Vector2.ZERO

func active() -> void:
	_active = true

func deactive() -> void:
	_active = false

func is_active() -> bool:
	return _active
