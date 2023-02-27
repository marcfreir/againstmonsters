extends Area2D

const SPEED = 80

var right
var left

var direction = 0
var previousRelease = preload("res://scenes/playerPower.tscn")
var previousPower = false

var power

var isAlive = true

signal dead
signal respawn

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	#set_process(true)


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
	if get_global_position().x < 8:
		set_global_position(Vector2(8, get_global_position().y))
		
	if get_global_position().x > 172:
		set_global_position(Vector2(172, get_global_position().y))
		
	if power and not previousPower and get_tree().get_nodes_in_group("playerPower").size() < 100:
		#Create the power releasing
		var release = previousRelease.instance()
		get_parent().add_child(release)
		release.set_global_position(get_global_position())
		
	previousPower = power

func start():
	show()
	set_process(true)

# Destroy the player
func destroy(object):
	if isAlive:
		isAlive = false
		set_process(false)
		emit_signal("dead")
		get_node("playerAnimationPlayer").play("defaultPlayerIsDead")
		yield(get_node("playerAnimationPlayer"), "animation_finished")
		emit_signal("respawn")
		set_process(true)
		isAlive = true
		get_node("playerSprite").set_frame(0)
		
		
