extends Node3D

@export var camera_00 : PhantomCamera3D
@export var camera_01 : PhantomCamera3D
@export var camera_02 : PhantomCamera3D
var current_ball :Node3D
var current_camera: PhantomCamera3D
var current_zone: int
var looking: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	camera_00 = $"../Player/PhantomCamera3D"
	current_camera = camera_00


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if looking == true:
		current_camera.look_at_target = current_ball
		current_camera.follow_target = current_ball

	elif looking == false:
		camera_01.priority = 0
		camera_02.priority = 0
func _on_player_ball_shot(ball):
	looking = true
	current_ball = ball
	camera_00.priority = 0
	current_camera.look_at_target = ball
	current_ball.ball_lost.connect(_on_ball_lost)

func _on_player_player_moved():
	current_camera = camera_00
	current_camera.priority = 100
	camera_01.priority = 1
	camera_02.priority = 1
	looking = false
	
	
func _on_ball_lost(): 
	print("ball lost")
	camera_00.priority = 100
	camera_01.priority = 1
	camera_02.priority = 1

func _on_far_area_body_entered(body):
	if body.is_in_group("BALL"):
		current_camera = camera_02
		camera_02.priority = 100
		camera_01.priority = 0

func _on_first_area_body_entered(body):
	if body.is_in_group("BALL"):
		print("zone one")
		camera_01.priority = 100
		camera_02.priority = 0
		current_camera = camera_01
