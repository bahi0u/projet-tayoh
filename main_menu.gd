extends Control

@onready var map = "res://Tutorial.tscn"
# Called when the node enters the scene tree for the first time.
func _ready():
	$CenterContainer/VBoxContainer/HBoxContainer.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_demo_level_button_pressed():
	get_tree().change_scene_to_file(map)
func _on_quit_button_pressed():
	$CenterContainer/VBoxContainer/HBoxContainer.visible = true


func _on_quit_button_2_pressed():
	get_tree().quit()


func _on_quit_button_3_button_down():
	$CenterContainer/VBoxContainer/HBoxContainer.visible = false
