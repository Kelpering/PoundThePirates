extends Area2D

signal score_change(add_score)

@export var open_chance = 3
@export var pirate_chance = 2
@export var taunt_chance = 5

var state = 0
var screen_size

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _unhandled_input(event):
	if clicked(event):
		$Hammer.show()
		if state == 2:
			$AudioStreamPlayer.play()
			score_change.emit(1)
		elif state == 3:
			pass
		else:
			score_change.emit(-1)
		state = 3
		if (get_tree()):
			await get_tree().create_timer(0.5).timeout
		state = 0
		$Chest.set_frame_and_progress(0, 0)
		$Head.hide()
		$Hammer.hide()

# A function that returns whether or not an object was clicked (on collision object)
func clicked(event):
	if event is InputEventScreenTouch and event.is_pressed():
		var mouse_pos = get_viewport().get_mouse_position().clamp(Vector2.ZERO, screen_size)
		var sprite_size = $CollisionShape2D.shape.get_rect().size
		var sprite_pos = Vector2($CollisionShape2D.global_position.x - sprite_size.x/2, $CollisionShape2D.global_position.y - sprite_size.y/2)
		if (sprite_pos.x <= mouse_pos.x and mouse_pos.x <= sprite_pos.x+sprite_size.x):
			if (sprite_pos.y <= mouse_pos.y and mouse_pos.y <= sprite_pos.y+sprite_size.y):
				return true
	return false

func _on_timer_timeout():
	match(state):
		0: #Closed
			if randi_range(0,open_chance) == 0:
				$Chest.set_frame_and_progress(1,0)
				if randi_range(0,pirate_chance) == 0:
					state = 2
					$Head.show()
				else:
					state = 1
		1:	#Open and no pirate
			$Chest.set_frame_and_progress(0,0)
			$Head.hide()
			state = 0
		2:	#Open and pirate
			$Chest.set_frame_and_progress(0,0)
			$Head.hide()
			state = 0
			score_change.emit(-1)
