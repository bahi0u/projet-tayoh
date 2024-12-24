extends Node3D

@export var current_player: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	
#SPAWN PLAYER WHEN THE LEVEL IS STARTED
	if current_player:
		var player = current_player.instantiate()
		get_tree().current_scene.add_child.call_deferred(player)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
