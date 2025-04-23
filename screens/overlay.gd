extends Control

var _seconds := 0.0
var _timer_running := false
var _moves_count := 0

func _process(delta: float) -> void:
	if _timer_running:
		_seconds += delta
		_update_timer()

func _leading_zeros(n: int, digits: int = 2) -> String:
	var s := str(n)
	s = "0".repeat(digits - len(s)) + s
	return s

func _update_timer() -> void:
	var s := _seconds
	var m := floorf(_seconds / 60)
	s -= m * 60
	$Info/Time.text = "TIME: %s:%.3f" % [_leading_zeros(m), s]

func start_timer() -> void:
	_timer_running = true

func stop_timer() -> void:
	_timer_running = false

func increment_moves_count() -> void:
	_moves_count += 1
	$Info/Moves.text = "MOVES: %d" % [_moves_count]
