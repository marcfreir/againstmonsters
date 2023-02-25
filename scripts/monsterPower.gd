extends Area2D

const SPEED = 120
const DIRECTION = Vector2(0,1)


# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	translate(DIRECTION * SPEED * delta)

func destroy(object):
	queue_free()


func _on_monsterPower_area_entered(area):
	print(area)
