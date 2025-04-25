extends RigidBody2D
class_name Box

signal selected

var _mouse_over := false

enum Kind {One, Two, Three}
@export var _kind: Kind = Kind.One:
	set(value):
		_kind = value
		_set_mass_based_on_kind()
		_set_color_based_on_kind()

func _ready() -> void:
	_set_mass_based_on_kind()
	_set_color_based_on_kind()
	
	mouse_entered.connect(_mouse_entered)
	mouse_exited .connect(_mouse_exited)

func _process(_delta: float) -> void:
	if $Movable.is_active():
		modulate = Color.INDIAN_RED
	else:
		modulate = Color.WHITE

func _input(event: InputEvent) -> void:
	if true: return
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT and _mouse_over:
			selected.emit()
			$Movable.active()

func _mouse_entered() -> void:
	_mouse_over = true

func _mouse_exited() -> void:
	_mouse_over = false

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

func movable() -> Movable:
	return $Movable as Movable
