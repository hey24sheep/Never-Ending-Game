extends Camera2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	limit_left = get_viewport().size.x
	limit_right = get_viewport().size.x
	limit_bottom = get_viewport().size.y
	pass 
