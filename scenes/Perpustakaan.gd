extends Control

func _ready():
	for i in get_tree().get_nodes_in_group("item"):
		i.get_child(1).visible_characters = 0
		i.get_child(0).connect("mouse_entered", self, "on_mouse", [true, i.get_child(1)])
		i.get_child(0).connect("mouse_exited", self, "on_mouse", [false, i.get_child(1)])
		i.get_child(0).connect("pressed", self, "on_selected", [i.name])


func on_mouse(entered: bool, label: Label):
	if entered:
		label.visible_characters = -1
		return
	
	label.visible_characters = 0

func on_selected(selected_name: String):
	print(selected_name)
