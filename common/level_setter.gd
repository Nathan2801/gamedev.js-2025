extends Node
class_name LevelSetter

@export var _level_number := 0
@onready var _target: Button = get_parent()

func _ready() -> void:
	_target.pressed.connect(_target_pressed)
	
func _target_pressed() -> void:
	Globals.level_number = _level_number
