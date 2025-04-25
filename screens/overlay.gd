extends Control
class_name Overlay

var _moves_count := 0

func start_timer() -> void:
	$Margin/Info/Time.start()

func stop_timer() -> void:
	$Margin/Info/Time.stop()

func get_time() -> float:
	return $Margin/Info/Time.time()

func get_moves() -> int:
	return _moves_count

func increment_moves_count() -> void:
	_moves_count += 1
	$Margin/Info/Moves.text = "Moves: %d" % [_moves_count]
