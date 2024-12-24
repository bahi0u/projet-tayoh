extends MeshInstance3D

var driver_pos: Vector3 = Vector3(0,1,152)
var iron_pos: Vector3 = Vector3(0,1,117)
var putter_pos: Vector3 = Vector3(0,1,17)
# Called when the node enters the scene tree for the first time.
func _ready():
	self.set_position(driver_pos)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_player_club_changed(current_club):
	if current_club == "Driver":
		self.set_position(driver_pos)
	elif current_club == "Putter":
		self.set_position(putter_pos)
	elif current_club == "Iron":
		self.set_position(iron_pos)
