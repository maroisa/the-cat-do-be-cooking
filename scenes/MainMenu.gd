extends Control

onready var cat_idle_texture = preload("res://assets/title/cat/cat_idle.png")
onready var cat_blink_texture = preload("res://assets/title/cat/cat_blink.png")

func _ready():
	$AnimationPlayer.connect("animation_finished", self, "on_cat_finished")
	
	for i in $M/HB.get_children():
		name.to_lower()
		i.get_child(0).connect("pressed", self, "on_" + i.name.to_lower() + "_pressed")
		i.get_child(0).connect("mouse_entered", self, "on_mouse", [true, i.get_child(1)])
		i.get_child(0).connect("mouse_exited", self, "on_mouse", [false, i.get_child(1)])
		i.get_child(1).visible_characters = 0
	
	$About/M/M/VB/TextureButton.connect("pressed", self, "on_about_close")
	
	$About/M/M/VB/M/RichTextLabel.connect("meta_clicked", self, "on_meta_clicked")
	
	$About.modulate.a = 0
	$About.hide()
	
	randomize()

func on_mouse(toggle, label):
	label.visible_characters = -1 if toggle else 0

func on_about_close():
	$Tween.interpolate_property($About, "scale", Vector2(1, 1), Vector2(0.75, 0.75), 0.25, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	$Tween.interpolate_property($About, "modulate:a", 1, 0, 0.25, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	$Tween.interpolate_property($About, "position", Vector2(0,0), ($About/M/Panel.rect_size / 8), 0.25, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	
	$Tween.start()
	
	yield($Tween, "tween_completed")
	$About.hide()

func on_about_pressed():
	$About.show()
	
	$Tween.interpolate_property($About, "scale", Vector2(0.75, 0.75), Vector2(1, 1), 0.25, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	$Tween.interpolate_property($About, "modulate:a", 0, 1, 0.25, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	$Tween.interpolate_property($About, "position", ($About/M/Panel.rect_size / 8), Vector2(0,0), 0.25, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	
	$Tween.start()

func on_exit_pressed():
	get_tree().quit()

func on_play_pressed():
	get_tree().change_scene("res://scenes/Map.tscn")

func on_cat_finished(anim_name):
	$AnimationPlayer.play("cat_anim")
	
	var rand = randf()
	
	if rand <= 0.7:
		$Cat.texture = cat_idle_texture
		return
	
	print("Randomized")
	$Cat.texture = cat_blink_texture

func on_meta_clicked(meta):
	OS.shell_open(str(meta))
