extends ColorRect

@onready var cursor = $"../../Cursor"
@onready var bar = $".."
var charged = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not charged:
		self.position = cursor.position
		self.size.x = bar.size.x + 100
	else:
		self.position = self.position


func _on_ui_shot_imminent(): #called whenever player has selected shot power
	charged = true

func _on_ui_bar_depleted():
	charged = false
