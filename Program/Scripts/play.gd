extends Button

func _on_button_down() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")

func _on_button_down2() -> void:
	get_tree().change_scene_to_file("res://scenes/shop.tscn")
