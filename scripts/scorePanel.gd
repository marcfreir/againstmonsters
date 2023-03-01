extends HBoxContainer


var playerRank = "1ST" setget set_playerRank
var playerName = "AAA" setget set_playerName
var playerScore = "999999" setget set_playerScore


func set_playerRank(value):
	playerRank = value
	get_node("rankPlayerLabel").set_text(str(value))
	
func set_playerName(value):
	playerName = value
	get_node("namePlayerLabel").set_text(str(value))

func set_playerScore(value):
	playerScore = value
	get_node("scorePlayerLabel").set_text(str(value))

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
