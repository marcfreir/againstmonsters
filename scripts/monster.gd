extends Area2D

export(int, "A", "B", "C") var type = 0

var score = 0

# List of all types of monsters
var attributes = [
	{
		monsterSprite = preload("res://sprites/monsterA_sheet.png"),
		score = 10
	},
	{
		monsterSprite = preload("res://sprites/monsterB_sheet.png"),
		score = 20
	},
	{
		monsterSprite = preload("res://sprites/monsterC_sheet.png"),
		score = 30
	}
]

# Called when the node enters the scene tree for the first time.
func _ready():
	var attribute = attributes[type]
	get_node("monsterSprite").set_texture(attribute.monsterSprite)
	score = attribute.score


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
