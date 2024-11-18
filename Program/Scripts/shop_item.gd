extends Button

var item_content = {
	"name" : "Default",
	"pirate" : "res://art/pirate.png",
	"chest" : "chest_default",
	"price" : 42,
	"booty" : 0
}

func _ready():
	text = item_content.name
	$price.text = "Price: " +  str(item_content["price"])

func _on_shop_item_button_down() -> void:
	var parent = get_parent().get_parent().get_parent()
	if parent.booty >= item_content["price"]:
		parent.booty -= item_content["price"]
		item_content["booty"] = parent.booty
		save_file(JSON.stringify(item_content))
	else:
		print("ERROR, NO BOOTY")
	
func save_file(save_text):
	var save_data = FileAccess.open("user://save.save", FileAccess.WRITE)
	save_data.store_line(save_text)
	save_data.close()
