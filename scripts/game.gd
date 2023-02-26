extends Node

var score = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	update_score()
	get_node("monsterGroup").connect("monster_down", self, "on_monsterGroup_monster_down")


func on_monsterGroup_monster_down(monster):
	score += monster.score
	update_score()

#Make the score be written on the HUD
func update_score():
	get_node("HUD/scoreLabel").set_text(str(score))
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
