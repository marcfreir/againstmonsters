extends Area2D

var score = 200

#Signal for the destroyed mothership
signal animation_destroyed(object)

# Called when the node enters the scene tree for the first time.
func _ready():
	$motherShipAudioStreamPlayer.play()
	get_node("runMotherShipAnimationPlayer").play("runMotherShip")
	yield(get_node("runMotherShipAnimationPlayer"), "animation_finished")
	queue_free()


func destroy(object):
	emit_signal("animation_destroyed", self)
	queue_free()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
