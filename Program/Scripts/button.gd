extends Button

@export var button_path = "res://scenes/main.tscn"
#
func _on_button_down() -> void:
	get_tree().change_scene_to_file(button_path)
