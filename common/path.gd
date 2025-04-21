extends Node2D
class_name Path

var a := Vector2.ZERO
var b := Vector2.ZERO

func _ready() -> void:
	visible = false

func _draw() -> void:
	var diff := b - a
	var angle := diff.normalized()
	var length := diff.length() * 0.1
	var center := a
	for _i in range(int(length)):
		draw_arc(center, 2, 0, PI * 2, 12, Color.WHITE)
		center += angle * 10
