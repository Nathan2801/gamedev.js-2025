extends Node2D

var _boxes: Array[Box]
var _current_body: RigidBody2D
var _impulse_line := Vector2.ZERO
var _level_started := false

@onready var _cursor := preload("res://assets/cursors/hand_small_point.png")
@onready var _open_cursor := preload("res://assets/cursors/hand_small_open.png")
@onready var _closed_cursor := preload("res://assets/cursors/hand_small_closed.png")

@onready var _path := $Path

@export var _reload_key := KEY_R
@export_file("*.tscn") var _complete_scene_path: String

func _ready() -> void:
	assert(_complete_scene_path != "")
	
	_set_boxes()
	_connect_boxes()
	_connect_ball()

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.keycode == _reload_key:
			reload()
		elif event.keycode == KEY_ESCAPE:
			get_tree().change_scene_to_file("res://screens/levels.tscn")
	elif event is InputEventMouseButton:
		_select_box_at_cursor(event)

func _process(_delta: float) -> void:
	if _current_body:
		_path.a = _current_body.position
		_path.b = _current_body.position + _impulse_line
		_path.a += $CenterOnScreen.position
		_path.b += $CenterOnScreen.position
	_redraw_path()
	_update_cursor()

func _start() -> void:
	$Overlay.start_timer()
	$CenterOnScreen/Map.unlock()
	_level_started = true

func _complete() -> void:
	_reset_cursor()
	$Overlay.stop_timer()
	Globals.level_time = $Overlay.get_time()
	Globals.level_moves = $Overlay.get_moves()
	get_tree().change_scene_to_file(_complete_scene_path)

func _set_boxes() -> void:
	_boxes.clear()
	for box in find_children("Box*"):
		if box is Box:
			_boxes.append(box)

func _connect_boxes() -> void:
	for box in _boxes:
		box.selected.connect(_box_selected)
		var movable: Movable = box.movable()
		movable.impulse_update.connect(_impulse_update)
		movable.impulse_started.connect(_impulse_started)
		movable.impulse_applied.connect(_impulse_applied)

func _box_selected() -> void:
	for box in _boxes:
		box.movable().deactive()

func _impulse_started(body: RigidBody2D) -> void:
	_path.visible = true
	_current_body = body

func _impulse_applied() -> void:
	if not _level_started:
		_start()
	_path.visible = false
	$Overlay.increment_moves_count()

func _impulse_update(a: Vector2, b: Vector2) -> void:
	_impulse_line = (b - a) * 0.2

func _connect_ball() -> void:
	$CenterOnScreen/Ball.collided_with_plug.connect(_complete)

func _redraw_path() -> void:
	_path.queue_redraw()

func _update_cursor() -> void:
	var cursor: Resource
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		cursor = _closed_cursor
	else:
		cursor = _open_cursor
	DisplayServer.cursor_set_custom_image(cursor)

func _reset_cursor() -> void:
	DisplayServer.cursor_set_custom_image(_cursor)

func _select_box_at_cursor(event: InputEventMouse) -> void:
	var point := PhysicsPointQueryParameters2D.new()
	point.position = event.position + Vector2(16, 16)
	var space := get_world_2d().direct_space_state
	var collisions := space.intersect_point(point, 1)
	for collision in collisions:
		var collider = collision["collider"]
		if collider is Box:
			collider.selected.emit()
			collider.movable().active()

func reload() -> void:
	get_tree().reload_current_scene()
