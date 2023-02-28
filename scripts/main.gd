extends Node


var previousGame = preload("res://scenes/game.tscn")
var game


######
var extraLifeIndex = 0
var score = 0
var lives = 3
######

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func new_game():
	#Check if there is a game instace alredy playing
	if game != null:
		game.queue_free()
	game = previousGame.instance()
	
	# Give me an error
	#add_child(game)
	
	# Replacement/Update
	call_deferred("add_child", game)
	
	game.connect("game_over", self, "on_game_over")
	game.connect("victory", self, "on_victory")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_playButton_pressed():
	get_node("newGamePlayButton").hide()
	#get_node("highScore").hide()
	new_game()

func on_game_over():
	get_node("newGamePlayButton").show()

func on_victory():
	var extraLifeIndex = game.extraLifeIndex
	var score = game.score
	var lives = game.lives
	new_game()
	game.extraLifeIndex = extraLifeIndex
	game.score = score
	game.lives = lives
	
	game.update_HUD()

