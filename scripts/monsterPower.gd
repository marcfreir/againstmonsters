extends Area2D

const SPEED = 120
const DIRECTION = Vector2(0,1)


# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("MONSTER_POWER")
	set_process(true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	translate(DIRECTION * SPEED * delta)
	if get_global_position().y > 265:
		destroy(self)

func destroy(object):
	queue_free()


func _on_monsterPower_area_entered(area):
	if area.has_method("destroy"):
		area.destroy(self)
		destroy(self)
