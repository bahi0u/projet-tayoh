extends RigidBody3D

@export var launch_direction: Vector3 = Vector3(1, 1, 0)  # Launch in X-Y plane by default
@export var launch_speed: float = 100  # Initial speed
@onready var timer = $FinishedMovingTimer

const STOP_THRESHOLD: float = 0.1
var is_moving: bool = true
var ball_position: Vector3


signal ball_stopped
signal timeout
signal ball_moving
signal ball_lost
# Called when the node enters the scene tree for the first time.
func _ready():
	# Apply velocity in the specified direction
	linear_velocity = launch_direction.normalized() * launch_speed
	print("Initial velocity:", linear_velocity)
	

func _process(delta):
	if is_moving and linear_velocity.length() < STOP_THRESHOLD:
		is_moving = false
		ball_stopped.emit()  # Emit the signal when the ball stops
		
		
func _on_ball_stopped():
	timer.start()
	ball_position = self.position

func _on_finished_moving_timer_timeout():
	timeout.emit(ball_position)
	queue_free()


func _on_ob_timer_timeout():
	ball_lost.emit()
	queue_free() 
