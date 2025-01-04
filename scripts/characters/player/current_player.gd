extends CharacterBody3D
#


enum States {IDLE,DRONE,AIMING}

var state: States = States.IDLE

signal drone

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if state == States.DRONE:
		drone.emit()



func set_state(new_state: int) -> void:
	var previous_state := state
	state = new_state
	# You can check both the previous and the new state to determine what to do when the state changes. This checks the previous state.
	
