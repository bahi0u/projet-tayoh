extends Node

var selected_level: PackedScene

var start_menu = preload("res://main_menu.tscn")
var menu_shown: bool
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(_event):
	if Input.is_action_just_pressed("start") and menu_shown == false:
		start_menu.instantiate()
		menu_shown = true
	if Input.is_action_just_pressed("start") and menu_shown == true:
		menu_shown = false
		print("close menu")
		queue_free()
		
