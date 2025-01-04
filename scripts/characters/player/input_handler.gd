extends Node


@onready var player = $".."
@onready var camera = $"../PhantomCamera3D"
@onready var cam_height = camera.position.y

@export var cam_speed = 5 #default 5


var value: float = 0
var rotation_speed: float = 0.0
var max_speed = 200

func _physics_process(delta):
	
	if Input.is_action_pressed("up"):
		camera.rotation.x -= 0.0089
		camera.position.y += 0.31
		player.state = DRONE
		
	if Input.is_action_pressed("down"):
		camera.rotation.x += 0.0089
		camera.position.y -= 0.31
		
	camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-30.0), deg_to_rad(0))
	camera.position.y = clamp(camera.position.y, cam_height, 20)
	
	
	if Input.is_action_pressed("left") and Input.is_action_pressed("right"):
		return
		
	if Input.is_action_pressed("left"):
		value += cam_speed
	elif Input.is_action_pressed("right"):
		value -= cam_speed
	else:
		return
		
	value = clamp(value, -max_speed, max_speed)
	rotation_speed = value / 10000 #Get the value into 0.2 form so its not too speedy
	player.rotation.y += rotation_speed 

func _input(event):
	if Input.is_action_just_released("left"):
		value = 0
	elif Input.is_action_just_released("right"):
		value = 0
