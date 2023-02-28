extends Node

const EXTRA_LIFE_POINTS = [1000, 5000, 10000, 50000]

#Struct
var gameData = {
	extraLifeIndex = 0,
	score = 0,
	lives = 3
} setget set_gameData

signal game_over
signal victory

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	update_score()
	get_node("monsterGroup").connect("monster_down", self, "on_monsterGroup_monster_down")
	get_node("monsterGroup").connect("monster_ready", self, "on_monsterGroup_monster_ready")
	get_node("monsterGroup").connect("area_conquered", self, "on_monsterGroup_area_conquered")
	get_node("monsterGroup").connect("victory", self, "on_monsterGroup_victory")
	get_node("player").connect("dead", self, "on_player_dead")
	get_node("player").connect("respawn", self, "on_player_respawn")


func on_monsterGroup_monster_down(monster):
	gameData.score += monster.score
	
	#The player get more lives
	if gameData.extraLifeIndex < EXTRA_LIFE_POINTS.size() and gameData.score >= EXTRA_LIFE_POINTS[gameData.extraLifeIndex]:
		gameData.lives += 1
		update_lives()
		gameData.extraLifeIndex += 1
	update_score()

func on_monsterGroup_monster_ready():
	get_node("player").start()
	
func on_monsterGroup_area_conquered():
	game_over()

#Give victory to the player
func on_monsterGroup_victory():
	get_node("monsterGroup").stop_all()
	get_node("player").disable()
	emit_signal("victory")

#Make the score be written on the HUD
func update_score():
	get_node("HUD/scoreLabel").set_text(str(gameData.score))
	
func update_lives():
	get_node("HUD/showLife").playerLives = gameData.lives

func update_HUD():
	update_score()
	update_lives()

func on_player_dead():
	get_node("monsterGroup").stop_all()
	#Take lives of the player when it dies
	gameData.lives -= 1
	update_lives()
	get_tree().call_group("MONSTER_POWER", "destroy", self)

func on_player_respawn():
	#Check if player lives is less than or equal to 0 to to call game over 
	if gameData.lives <= 0:
		game_over()
	else:
		get_node("monsterGroup").start_all()

func game_over():
	get_node("monsterGroup").stop_all()
	get_node("player").disable()
	emit_signal("game_over")
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func set_gameData(value):
	gameData = value
	update_HUD()
