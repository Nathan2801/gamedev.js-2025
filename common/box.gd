extends RigidBody2D

enum Kind {One, Two, Three}
@export var _kind: Kind = Kind.One:
	set(value):
		_kind = value
		_set_mass_based_on_kind()
		_set_color_based_on_kind()

@export var _active_key := KEY_NONE

func _ready() -> void:
	_set_mass_based_on_kind()
	_set_color_based_on_kind()
	
func _process(delta: float) -> void:
	if $Movable.is_active():
		modulate = Color.INDIAN_RED
	else:
		modulate = Color.WHITE

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.keycode == _active_key:
			$Movable.active()
		else:
			$Movable.deactive()

func _set_mass_based_on_kind():
	match _kind:
		Kind.One:   mass = 2
		Kind.Two:	mass = 3
		Kind.Three: mass = 4

func _set_color_based_on_kind():
	match _kind:
		Kind.One:   modulate = Color.LIGHT_BLUE
		Kind.Two:   modulate = Color.GOLD
		Kind.Three: modulate = Color.INDIAN_RED
