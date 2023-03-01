extends Node


var previousGame = preload("res://scenes/game.tscn")
var game

var highScoresList = [
	{name = "AAA", score = 1000},
	{name = "BBB", score = 900},
	{name = "CCC", score = 800},
	{name = "DDD", score = 700},
	{name = "EEE", score = 600},
	{name = "FFF", score = 500},
	{name = "GGG", score = 400},
	{name = "HHH", score = 300},
	{name = "III", score = 200},
	{name = "JJJ", score = 100}
]


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func new_game():
	#Check if there is a game instace alredy playing
	if game != null:
		game.queue_free()
	game = previousGame.instance()
	
	# Give me an error
	add_child(game)
	
	# Replacement/Update
	#call_deferred("add_child", game)
	
	game.connect("game_over", self, "on_game_over")
	game.connect("victory", self, "on_victory")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_playButton_pressed():
	get_node("newGamePlayButton").hide()
	
	new_game()

func on_game_over():
	
	for highScore in highScoresList:
		if game.gameData.score > highScore.score:
			print(highScore)
			break
	
	get_node("newGamePlayButton").show()

func on_victory():
	var gameData = game.gameData
	new_game()
	game.gameData = gameData
	

