extends Control

@onready var cursor = $ShootBar/Cursor
@onready var trail = $ShootBar/Background/CursorTrail
@export var curspeed = 200
@onready var bar = $ShootBar/Background
@onready var curshape = $ShootBar/Cursor/CursorArea/CursorShape
@export var player: Node
@export var shot_power = 0
var number_of_shot : int = 0


var registered_shot = 0
var is_charging = false
var is_discharging = false
var cursor_position: float = 0.0
var current_zone: int = -1 
var stopped_position: float
var cursor_stop = false
var cursor_reset = 0
var locked = false

var is_aiming: bool = false

signal bar_full
signal bar_depleted
signal aiming #is emmitted when the Jauge is moving
signal shooting #is emitted when the cursor has hit a value
signal shot_imminent
signal PANGYA


func _ready():
	cursor_position = cursor_reset
	player.player_moved.connect(_on_player_moved)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if cursor_stop:
		cursor_position = stopped_position
	if is_charging == true:
		aiming.emit()
		is_discharging = false
		cursor_position += curspeed * delta  # Increment position based on curspeed
		cursor_position = clamp(cursor_position, 0.0, bar.size.x) #make cursor not go too far
		cursor.position.x = cursor_position
		if cursor.position.x == bar.size.x:
			bar_full.emit() 

	if is_discharging == true: 
		aiming.emit()
		cursor_position -= curspeed * delta
		cursor.position.x = cursor_position
		if cursor.position.x <= 1:
			bar_depleted.emit() 
		
	if player.ready_to_aim == false: #CHANGE SHOOTBAR OPACITY WHEN CAM IS MOVED 
		$ShootBar.modulate.a = 0.25
	elif player.ready_to_aim == true:
		$ShootBar.modulate.a = 1


func _input(event):

	if Input.is_action_just_pressed("action") and player.ready_to_aim == true and is_discharging == false and not is_aiming: # First check if can shoot to initiate
		is_charging = true
	if Input.is_action_just_pressed("action"):
		var value = get_travel_value()
		if value >= 11:
			shot_power = value
			curshape.disabled = false
	if Input.is_action_just_pressed("action") and shot_power > 0:
		shot_imminent.emit()

	if Input.is_action_just_pressed("action") and current_zone > -1:
		PANGYA.emit(current_zone, shot_power)
	else:
		is_aiming = false
	
func get_travel_value() -> float:
	var value = cursor_position / bar.size.x  # Value as a ratio of traveled distance to total bar length
	return value * 100  # You can return this as a percentage or any scale you prefer


func _on_bar_full():
	is_charging = false
	is_discharging = true

func _on_bar_depleted():
	is_charging = false
	is_discharging = false
	shot_power = 0
	curshape.disabled = true
	current_zone = -1
	cursor_position = cursor_reset

func _on_aiming():
	is_aiming = true

#CALCULATE WHICH ZONE THE CURSOR IS BLACK=0, LEFT=1, MIDDLE=2, RIGHT=3
func _on_black_space_area_area_entered(area):
	if area.is_in_group("CURSOR"):
		current_zone = 0

func _on_left_pink_area_area_entered(area):
	if area.is_in_group("CURSOR"):
		current_zone = 1
func _on_white_area_area_entered(area):
	if area.is_in_group("CURSOR"):
		current_zone = 2

func _on_right_pink_area_area_entered(area):
	if area.is_in_group("CURSOR"):
		current_zone = 3


func _on_shot_imminent():
	pass
	
func _on_pangya(current_zone, shot_power):
	is_charging = false
	is_discharging = false
	number_of_shot += 1
	cursor_position = stopped_position

func _on_player_ball_shot(ball):
	bar_depleted.emit()
	
func _on_player_moved():
	is_aiming = false
