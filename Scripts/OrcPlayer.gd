extends KinematicBody2D

export(NodePath) var camera_path

var camera
var platform = preload("res://Scenes/Platform.tscn")
var world = 'res://Scenes/World.tscn'
var width
var height
var scoreHolder

const UP = Vector2(0, -1)
const GRAVITY = 20
const ACCELRATION = 50
const MAX_SPEED = 200
const JUMP_HEIGHT = -650

var motion = Vector2()

func _ready():
	width = get_viewport().size.x
	height = get_viewport().size.y
	camera = get_node(camera_path)
	
	pass

func _physics_process(delta):
	motion.y += GRAVITY
	var friction = false
	
	if Input.is_action_pressed("ui_right"):
		motion.x = min(motion.x+ACCELRATION, MAX_SPEED)
		$OrcSprite.flip_h = false
		$OrcSprite.play("Walk")
		friction = true
	elif Input.is_action_pressed("ui_left"):
		motion.x = max(motion.x-ACCELRATION, -MAX_SPEED)
		$OrcSprite.flip_h = true
		$OrcSprite.play("Walk")
		friction = true
	else:
		$OrcSprite.play("Idle")
		friction = true
	
	if Input.is_action_just_pressed("ui_select"):
		$OrcSprite.play("Attack")
		var new_platform = platform.instance()
		new_platform.position = Vector2(position.x,position.y+25.5)
		get_parent().add_child(new_platform)
	
	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			motion.y = JUMP_HEIGHT
			var score = abs((int(position.y)*1))
			$GUI/ScoreLabel.setScore(score)
		if friction == true:
			motion.x = lerp(motion.x, 0, 0.2)
	else:
		if motion.y < 0:
			$OrcSprite.play("Jump")
		else:
			$OrcSprite.play("Fall")
			
		if friction == true:
			motion.x = lerp(motion.x, 0, 0.05)
		
	motion = move_and_slide(motion, UP)
	pass

func exit_screen():
	# user going left or right on screen, wrap screen
	if position.x > camera.position.x and motion.x > 0:
		position.x = -width/2-30
	else: if position.x < camera.position.x and motion.x < 0:
		position.x = width/2+30
	else: 
		# positive motin on y axis,
		# user is falling, goes beyond camera y, restart game
		if motion.y > camera.position.y:
			get_tree().change_scene(world)
		
	pass 
