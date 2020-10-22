extends Node2D

export(NodePath) var camera_path
var camera
var platform
var width

func _ready():
	camera = get_node(camera_path)
	platform = preload('res://Scenes/Platform.tscn')
	create_new_platforms()
	pass
	

func create_new_platforms():
	print(camera.position)
	width = get_viewport().size.x
	var y = 1000
	randomize()
#	while y > -((1 if camera.position.y == 0 else camera.position.y) * 1000):
	while y > 0:
		var new_platform = platform.instance()
		new_platform.position = Vector2(rand_range(-width/2,width/2),rand_range(-50000,get_viewport().size.y)/2)
		call_deferred("add_child", new_platform)
#		y -= rand_range(0,190)
		y -= 1
