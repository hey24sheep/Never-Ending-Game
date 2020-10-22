extends Label

var value = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update()
	
func setScore(val:int):
	if (val > value):
		value += val
		update()

func reset():
	value = 0
	update()	

func update():
	$Value.text = String(value)
