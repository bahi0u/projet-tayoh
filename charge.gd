extends Label

@onready var ui = $".."
@onready var shotvalue = $"."
@onready var shots = $"../Shots"
@onready var club = $"../Club"
var default_club = "Driver"

# Called when the node enters the scene tree for the first time.
func _ready():
	ui.player.club_changed.connect(_on_club_changed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.text = "is charging " + str(ui.is_charging)
	shotvalue.text = str(ui.shot_power)
	shots.text = "SHOT: " + str(ui.number_of_shot)
	club.text = default_club
	
func _on_club_changed(current_club):
	default_club = current_club
