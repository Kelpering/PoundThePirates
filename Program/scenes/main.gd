extends Control

var default_save = JSON.stringify({
	"name" : "Default",
	"pirate" : "res://art/pirate1.png",
	"chest" : "chest_default",
	"price" : 24,
	"booty" : 0
	})

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if (FileAccess.open("user://save.save", FileAccess.READ) == null):
		var save_data = FileAccess.open("user://save.save", FileAccess.WRITE)
		save_data.store_line(default_save)
		save_data.close()
