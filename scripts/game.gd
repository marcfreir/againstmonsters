extends Node



# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("monsterGroup").connect("monster_down", self, "on_monsterGroup_monster_down")


func on_monsterGroup_monster_down(monster):
	print(monster.score)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
