extends VBoxContainer


const PREVIOUSITEM = preload("res://scenes/scorePanel.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	for anything in range(10):
		var item = PREVIOUSITEM.instance()
		item.playerName = str(anything) + "AA"
		add_child(item)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
