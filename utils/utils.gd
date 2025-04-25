extends Node

func leading_zeros(n: int, digits: int = 2) -> String:
	var s := str(n)
	s = "0".repeat(digits - len(s)) + s
	return s

# NOTE: I think no one would take more than 59 minutes
# in a level to break this code... right?
func time_string_from_seconds(s: float) -> String:
	var m := floorf(s / 60)
	s -= m * 60
	return "%s:%.3f" % [leading_zeros(m), s]
