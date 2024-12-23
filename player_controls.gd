extends Node3D

@onready var gc = $GroundChecker
@onready var camera = $PhantomCamera3D
@onready var cam_height = camera.position.y
@onready var trajectory_visualizer : MeshInstance3D = $TrajectoryVisualizer
@onready var spawn_point: Marker3D = $SpawnPoint
@export var ball_scene: PackedScene

var ball_power: float
var is_aiming = false
var ready_to_aim = true

signal ball_shot
signal player_moved

# cam_height is the initial height of the camera, as a variable in case a character needs to be filmed higher

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	draw_trajectory(Vector3(spawn_point.global_transform.basis.z + Vector3.UP * 0.5).normalized(), 30)

# Rotate the character and orient the camera
# First rotate the player node then angle and move the camera node (child of player)
	if Input.is_action_pressed("left") and is_aiming == false:
		
		self.rotation.y += 0.02
		
		
		
	if Input.is_action_pressed("right") and is_aiming == false:
		self.rotation.y -= 0.02

	if Input.is_action_pressed("up") and is_aiming == false:
		camera.rotation.x -= 0.0089
		camera.position.y += 0.31
		
	if Input.is_action_pressed("down") and is_aiming == false:
		camera.rotation.x += 0.0089
		camera.position.y -= 0.31
	
#  Clamp all the rotation so that it doesn't loop around
	camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-30.0), deg_to_rad(0))
	camera.position.y = clamp(camera.position.y, cam_height, 20)
	
# Check if cam is in default orientation before shooting
	if camera.position.y != cam_height or camera.rotation.x != 0:
		ready_to_aim = false
	else:
		ready_to_aim = true

func _input(event):
	
	if Input.is_action_pressed("action") and ready_to_aim == false:
		camera.rotation.x = 0
		camera.position.y = cam_height


func _on_ui_on_aiming():
	is_aiming = true      


func _on_ui_pangya(current_zone, shot_power):
	ball_power = shot_power
	print(current_zone)
	print(ball_power)
	spawn_ball()
	$ShootingSound.playing = true


func spawn_ball():
	if ball_scene:
		var ball = ball_scene.instantiate()
		ball.transform.origin = spawn_point.global_transform.origin #get spawnpoint origin
		var forward_direction = spawn_point.global_transform.basis.z #get Forward axis
		var upward_component = Vector3.UP # Add some upward motion
		ball.launch_direction = (forward_direction + upward_component).normalized()
		ball.launch_speed = ball_power # Adjust speed as needed
		get_tree().current_scene.add_child(ball)
		ball_shot.emit(ball)
		ball.timeout.connect(_on_timeout)



func draw_trajectory(launch_direction: Vector3, ball_power: float = 100, gravity: float = -9.8):
	if not trajectory_visualizer:
		return
	# Calculate trajectory points
	var points = []
	var position = Vector3.ZERO
	var velocity = launch_direction.normalized() * ball_power
	var time_step = 0.2  # Smaller value = smoother curve

	for i in range(50):  # Simulate for 50 steps	
		position += velocity * time_step
		velocity.y += gravity * time_step
		points.append(position)
		if position.y < 0:
			break  # Stop when the arc hits the ground
# Generate the trajectory mesh
	var surface_tool = SurfaceTool.new()
	surface_tool.begin(Mesh.PRIMITIVE_LINE_STRIP)
	for point in points:
		surface_tool.add_vertex(point)
# Finish the mesh and assign it to the visualizer
	var mesh = surface_tool.commit()
	trajectory_visualizer.mesh = mesh



func _on_timeout(ball_position):
	print("TIMEOUT")
	self.position = ball_position
	player_moved.emit()
