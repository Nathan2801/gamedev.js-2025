extends RigidBody2D
class_name Ball

signal collided_with_plug

func _on_body_entered(body: Node) -> void:
	if body is Plug:
		collided_with_plug.emit()
