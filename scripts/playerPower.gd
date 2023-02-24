extends Area2D

var powerSpeed = 180
var powerDirection = Vector2(0,-1)

# Called when the node enters the scene tree for the first time.
func _ready():
	#Create list to group the objects
	add_to_group("playerPower")
	set_process(true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#Movement of the power release accordingly to the frame time
	translate(powerDirection * powerSpeed * delta)
	
	#Check if after moving the power, it passed the y axis (position 0)
	if get_global_position().y < 0:
		#Free the memory after the object has been released
		queue_free()
