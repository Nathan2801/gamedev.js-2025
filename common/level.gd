extends Node2D

@export var _reload_key := KEY_R

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.keycode == _reload_key:
			reload()

func reload() -> void:
	get_tree().reload_current_scene()
