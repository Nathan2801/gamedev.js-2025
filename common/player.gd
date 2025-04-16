extends RigidBody2D

func _on_body_entered(body: Node) -> void:
	if body.name == "End":
		get_tree().quit()
