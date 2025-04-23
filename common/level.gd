extends Node2D

var _boxes: Array[Box]
var _current_body: RigidBody2D
var _impulse_line := Vector2.ZERO
@export var _reload_key := KEY_R

func _ready() -> void:
	_set_boxes()
	_connect_boxes()
	_connect_impulse_signals()

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.keycode == _reload_key:
			reload()
		elif event.keycode == KEY_ESCAPE:
			get_tree().change_scene_to_file("res://screens/levels.tscn")
	elif event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			_start()

func _process(delta: float) -> void:
	if _current_body:
		$Path.a = _current_body.position
		$Path.b = _current_body.position + _impulse_line
	_redraw_path()

func _start() -> void:
	$Map.unlock()
	$Overlay.start_timer()

func _stop() -> void:
	$Map.lock()
	$Overlay.stop_timer()

func _set_boxes() -> void:
	_boxes.clear()
	for box in find_children("Box*"):
		if box is Box:
			_boxes.append(box)

func _connect_boxes() -> void:
	for box in _boxes:
		box.selected.connect(_box_selected)
		var f: Callable = $Overlay.increment_moves_count
		box.movable().impulse_applied.connect(f)

func _box_selected() -> void:
	for box in _boxes:
		box.movable().deactive()

func _impulse_started(body: RigidBody2D) -> void:
	$Path.visible = true
	_current_body = body

func _impulse_applied() -> void:
	$Path.visible = false

func _impulse_update(a: Vector2, b: Vector2) -> void:
	_impulse_line = (b - a) * 0.2

func _connect_impulse_signals() -> void:
	for box in _boxes:
		var movable: Movable = box.movable()
		movable.impulse_update.connect(_impulse_update)
		movable.impulse_started.connect(_impulse_started)
		movable.impulse_applied.connect(_impulse_applied)

func _redraw_path() -> void:
	$Path.queue_redraw()

func reload() -> void:
	get_tree().reload_current_scene()
