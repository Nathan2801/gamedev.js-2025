extends Node
class_name Movable

var _locked := true
var _being_hovered := false
var _mouse_delta := Vector2.ZERO
@export var _impulse_limit := 100

@onready var target: RigidBody2D = get_parent()

func _ready():
	target.input_pickable = true
	target.mouse_entered.connect(func():
		_being_hovered = true)
	target.mouse_exited .connect(func():
		_being_hovered = false)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		_mouse_delta.x = event.screen_relative.x
		_mouse_delta.y = event.screen_relative.y
	elif event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			if _being_hovered:
				_locked = false
		else:
			_locked = true

func _process(_delta: float) -> void:
	if _locked:
		return
	var impulse := _mouse_delta*2.0
	var min_impulse := Vector2(-_impulse_limit, -_impulse_limit)
	var max_impulse := Vector2(+_impulse_limit, +_impulse_limit)
	impulse = impulse.clamp(min_impulse, max_impulse)
	target.apply_impulse(impulse)
