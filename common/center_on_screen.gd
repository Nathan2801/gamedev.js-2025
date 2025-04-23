@tool
extends Node
class_name CenterOnScreen

@export var _target: Node2D
@export_tool_button("Center on screen") var _button := _action

func _action() -> void:
	var width: int = ProjectSettings.get_setting("display/window/size/viewport_width")
	var height: int = ProjectSettings.get_setting("display/window/size/viewport_height")
	_target.position.x = width * 0.5
	_target.position.y = height * 0.5
