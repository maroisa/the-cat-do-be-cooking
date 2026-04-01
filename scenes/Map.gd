extends Control

func _ready():
	for i in $M/HB.get_children():
		i.get_node("Label").visible_characters = 0
		i.get_node("Button").connect("mouse_entered", self, "on_mouse", [true, i.get_node("Label")])
		i.get_node("Button").connect("mouse_exited", self, "on_mouse", [false, i.get_node("Label")])
		i.get_node("Button").connect("pressed", self, "on_" + i.name.to_lower() + "_pressed")

func on_mouse(entered: bool, label: Label):
	if entered:
		label.visible_characters = -1
		return
	
	label.visible_characters = 0

func on_perpustakaan_pressed():
	get_tree().change_scene("res://scenes/Perpustakaan.tscn")

func on_dapur_pressed():
	pass

func on_rumah_pressed():
	pass
