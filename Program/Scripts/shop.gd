extends Control

@export var booty = 42

var shop_list = [
	{
	"name" : "Default",
	"pirate" : "res://art/pirate1.png",
	"chest" : "chest_default",
	"price" : 24,
	"booty" : 0
	},
	{
	"name" : "BLUEEEEEEEEE",
	"pirate" : "res://art/pirate2.png",
	"chest" : "chest_blue",
	"price" : 42,
	"booty" : 0
	}
]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var json = JSON.new()
	json.parse(load_file())
	json = json.data
	booty = json.booty
	
	for item in shop_list:	
		var temp = load("res://scenes/cosmetic.tscn").instantiate()
		temp.get_node("ShopItem").item_content = item
		$GridContainer.add_child(temp)
	
func _process(_delta) -> void:
	$Booty.text = "Booty: " + str(booty)
	
func _exit_tree() -> void:
	pass

func load_file():
	var save_file = FileAccess.open("user://save.save", FileAccess.READ)
	var save_txt
	while save_file.get_position() < save_file.get_length():
		save_txt = save_file.get_line()
	save_file.close()
	return save_txt
