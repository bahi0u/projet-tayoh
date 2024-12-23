extends Node3D

@export var camera_00 : PhantomCamera3D
@export var camera_01 : PhantomCamera3D
@export var camera_02 : PhantomCamera3D
@export var camera_03 : PhantomCamera3D
@export var camera_04 : PhantomCamera3D


# Called when the node enters the scene tree for the first time.
func _ready():
	camera_00 = $"../Player/PhantomCamera3D"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_player_ball_shot(ball):
	camera_01.priority = 100
	camera_01.look_at_target = ball
	ball.ball_lost.connect(_on_ball_lost)


func _on_player_player_moved():
	camera_01.priority = 0
	camera_00.priority = 100
	
func _on_ball_lost(): 
	camera_01.priority = 0
	camera_00.priority = 100
