extends Area2D

const SPEED = 80

var right
var left

var direction = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	direction = 0
	
	#Make the player move to the right or to the left
	right = Input.is_action_pressed("ui_right")
	left = Input.is_action_pressed("ui_left")
	
	if right:
		direction += 1
	
	if left:
		direction -= 1
	
	translate(Vector2(1,0) * SPEED * direction * delta)
