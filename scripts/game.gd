extends Node

const EXTRA_LIFE_POINTS = [100, 150, 200]

var extraLifeIndex = 0


var score = 0

var lives = 3

signal game_over

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	update_score()
	get_node("monsterGroup").connect("monster_down", self, "on_monsterGroup_monster_down")
	get_node("monsterGroup").connect("monster_ready", self, "on_monsterGroup_monster_ready")
	get_node("monsterGroup").connect("area_conquered", self, "on_monsterGroup_area_conquered")
	get_node("player").connect("dead", self, "on_player_dead")
	get_node("player").connect("respawn", self, "on_player_respawn")


func on_monsterGroup_monster_down(monster):
	score += monster.score
	
	#The player get more lives
	if extraLifeIndex < EXTRA_LIFE_POINTS.size() and score >= EXTRA_LIFE_POINTS[extraLifeIndex]:
		lives += 1
		get_node("HUD/showLife").playerLives = lives
		extraLifeIndex += 1
	update_score()

func on_monsterGroup_monster_ready():
	get_node("player").start()
	
func on_monsterGroup_area_conquered():
	game_over()
#Make the score be written on the HUD
func update_score():
	get_node("HUD/scoreLabel").set_text(str(score))
	

func on_player_dead():
	get_node("monsterGroup").stop_all()
	#Take lives of the player when it dies
	lives -= 1
	get_node("HUD/showLife").playerLives = lives
	get_tree().call_group("MONSTER_POWER", "destroy", self)

func on_player_respawn():
	#Check if player lives is less than or equal to 0 to to call game over 
	if lives <= 0:
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
