extends Node2D
class_name Movable

signal impulse_update(a: Vector2, b: Vector2)
signal impulse_started(body: RigidBody2D)
signal impulse_applied

var _active := false
var _impulsionating := false
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

func _input(event: InputEvent) -> void:
	if not is_active():
		return
	if event is InputEventMouseMotion:
		if _impulsionating:
			_update_impulse(event.position)
	elif event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed and _target.get_contact_count() > 0:
				_start_impulse(event.position)
			elif _impulsionating:
				_apply_impulse()

func _start_impulse(mouse: Vector2) -> void:
	_impulsionating = true
	_impulse_origin = mouse
	impulse_started.emit(get_parent())
	_update_impulse(mouse)

func _update_impulse(mouse: Vector2) -> void:
	_impulse = mouse - _impulse_origin
	_impulse = _impulse.clamp(_min_range, _max_range)
	impulse_update.emit(_impulse_origin, mouse)

func _apply_impulse():
	_impulsionating = false
	_target.apply_impulse(_impulse * -1 * _target.mass)
	_impulse_origin = Vector2.ZERO
	impulse_applied.emit()

func active() -> void:
	_active = true

func deactive() -> void:
	_active = false

func is_active() -> bool:
	return _active
