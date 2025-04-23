extends Button
class_name ChangeSceneButton

@export_file("*.tscn") var _scene_path: String

func _ready() -> void:
	pressed.connect(_change_scene)

func _change_scene() -> void:
	get_tree().change_scene_to_file(_scene_path)
