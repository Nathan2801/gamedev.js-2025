extends Label
class_name TimeLabel

var _seconds := 0.0
var _running := false

func _process(delta: float) -> void:
	if _running:
		_seconds += delta
		text = "Time: " + Utils.time_string_from_seconds(_seconds)

func start() -> void:
	_running = true

func stop() -> void:
	_running = false

func time() -> float:
	return _seconds
