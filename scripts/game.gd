extends Node

var score = 0

var lives = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	update_score()
	get_node("monsterGroup").connect("monster_down", self, "on_monsterGroup_monster_down")
	get_node("player").connect("dead", self, "on_player_dead")
	get_node("player").connect("respawn", self, "on_player_respawn")


func on_monsterGroup_monster_down(monster):
	score += monster.score
	update_score()

#Make the score be written on the HUD
func update_score():
	get_node("HUD/scoreLabel").set_text(str(score))
	

func on_player_dead():
	get_node("monsterGroup").stop_all()
	#Take lives of the player when it dies
	lives -= 1
	get_node("HUD/showLife").playerLives = lives

func on_player_respawn():
	get_node("monsterGroup").start_all()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
