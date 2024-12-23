extends Label

@onready var charge = $".."
@onready var discharge = $"../Charge2"
@onready var shotvalue = $"../Charge3"
@onready var Zonevalue = $"../Charge4"
@onready var timer = $"../Charge5"
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.text = "is charging " + str(charge.is_charging)
	shotvalue.text = str(charge.shot_power)
	discharge.text = "is discharging" + str(charge.is_discharging)
	Zonevalue.text = "Current ZONE " + str(charge.current_zone)
	charge
