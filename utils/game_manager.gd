extends Node

#@export var player_scenes: PackedScene
#var players = []
#var current_player_index = 0
#
## Called when the node enters the scene tree for the first time.
#func _ready():
	#initialize_players(["Player1", "Player2", "Player3"])  # Example names
#
#
#func initialize_players(player_names: Array[String]) -> void:
	#for id in player_names.size():
		#var player = player_scenes.instantiate()
		#player.player_name = player_names[id]
		#player.player_id = id
		#players.append(player)
		#add_child(player)  # Add to the scene tree (or a specific container)
	#start_turn(0)
#
#func start_turn(player_index: int) -> void:
	#if players.size() > 0:
		#players[current_player_index].toggle_turn(false)
	#current_player_index = player_index
	#players[current_player_index].toggle_turn(true)
	#
#func end_turn():
	 ## Move to the next player's turn
	#start_turn((current_player_index + 1) % players.size())
#
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#pass
