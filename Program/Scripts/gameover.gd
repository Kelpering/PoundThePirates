extends Control

var booty_earned = Global.temp


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Booty.text = "booty_earned: " + str(booty_earned)
