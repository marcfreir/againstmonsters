extends Area2D

const SPEED = 80

var right
var left

var direction

var power

# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	direction = 0
	
	#Make the player move to the right or to the left using the right and left key
	right = Input.is_action_pressed("ui_right")
	left = Input.is_action_pressed("ui_left")
	power = Input.is_action_pressed("power_release")
	
	if right:
		direction += 1
	
	if left:
		direction -= 1
	
	translate(Vector2(1,0) * SPEED * direction * delta)
	
	#Set the boundaries/limit for the player (in the x axis)
	if get_global_position().x < 16:
		set_global_position(Vector2(16, get_global_position().y))
	if get_global_position().x > 180:
		set_global_position(Vector2(180, get_global_position().y))
		
	print(power)