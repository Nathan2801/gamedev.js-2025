@tool
extends Node2D
class_name CenterOnScreen

var _target := get_parent()

@export_tool_button("Center") var _button := _action
func _action() -> void:
	_center_on_editor()

func _ready() -> void:
	if not Engine.is_editor_hint():
		_center_on_viewport()
	get_viewport().size_changed.connect(_center_on_viewport)

func _center_on_editor() -> void:
	var width: int = ProjectSettings.get_setting("display/window/size/viewport_width")
	var height: int = ProjectSettings.get_setting("display/window/size/viewport_height")
	position.x = width * 0.5
	position.y = height * 0.5

func _center_on_viewport() -> void:
	position = get_viewport_rect().size * 0.5
