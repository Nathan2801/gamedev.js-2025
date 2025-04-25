extends Control

func _on_play_pressed() -> void:
	if Globals.goal_showed:
		get_tree().change_scene_to_file("res://screens/levels.tscn")
	else:
		Globals.goal_showed = true
		get_tree().change_scene_to_file("res://screens/goal.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()
