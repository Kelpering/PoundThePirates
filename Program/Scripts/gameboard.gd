extends Area2D

@export var score = 0
@export var score_change = 5
@export var lives = 3

var pirate_head
var chest_sprite
var chests = []
var level

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	level = 2
	
	var json = JSON.new()
	json.parse(load_file())
	json = json.data
	
	# Use saved cosmetics
	pirate_head = json.pirate
	chest_sprite = json.chest
	# Creates grid of Chest instances
	gridify(level)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	$Score.text = ("Score: " + str(score))
	$Lives.text = ("Lives: " + str(lives))
	
	if score > score_change:
		level += 1
		ungridify()
		gridify(level)
		score = 0
		score_change *= 2

func _on_score_change(add_score):
	if add_score == 1:
		score += 1
	elif add_score == -1:
		lives -= 1
		if lives == 0:
			gameover()
			
func save_file(save_text):
	var save_data = FileAccess.open("user://save.save", FileAccess.WRITE)
	save_data.store_line(save_text)
	save_data.close()

func load_file():
	var save_file = FileAccess.open("user://save.save", FileAccess.READ)
	var save_txt
	while save_file.get_position() < save_file.get_length():
		save_txt = save_file.get_line()
	save_file.close()
	return save_txt

func gridify(rows):
	var Chest = load("res://scenes/chest.tscn")
	for i in rows:
		for j in rows:
			chests.append(Chest.instantiate())
			add_child(chests[(i*rows)+j])
			var offset 
			if (rows == 1):
				offset = [200, 300]
			else:
				offset = [100, 200]
			chests[(i*rows)+j].position = Vector2(offset[0]+i*(360/rows), offset[1]+j*(360/rows))
			chests[(i*rows)+j].get_node("Chest").score_change.connect(_on_score_change)
			chests[(i*rows)+j].get_node("Chest/Chest").animation = chest_sprite
			chests[(i*rows)+j].get_node("Chest/Head").texture = load(pirate_head)

func ungridify():
	for chest in chests:
		remove_child(chest)
	chests.clear()
	
func gameover():
	var json = JSON.new()
	json.parse(load_file())
	json = json.data
	json.booty = json.booty + int(score * level)
	
	save_file(JSON.stringify(json))
	get_tree().change_scene_to_file("res://scenes/main.tscn")
