extends Control

@onready var _level := $Center/Container/Level
@onready var _time := $Center/Container/Time
@onready var _moves := $Center/Container/Moves

func _ready():
	var level := Globals.level_number
	_level.text = "Level " + str(level)
	var time := Globals.level_time
	_time.text = "Time: " + Utils.time_string_from_seconds(time)
	var moves := Globals.level_moves
	_moves.text = "Moves: " + str(moves)
