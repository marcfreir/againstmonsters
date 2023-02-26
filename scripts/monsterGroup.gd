extends Node2D

var previousMonsterPowerRelease = preload("res://scenes/monsterPower.tscn")
var previousMonsterExplosion = preload("res://scenes/monsterExplosion.tscn")

var direction = 1

const SPEED = Vector2(6, 0)

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("powerReleaseTimer").start()
	for monster in get_node("monsters").get_children():
		monster.connect("animation_destroyed", self, "on_monster_destroyed")


func power_release():
	var numMonsters = get_node("monsters").get_child_count()
	var monster = get_node("monsters").get_child(randi() % numMonsters)
	var monsterPowerRelease = previousMonsterPowerRelease.instance()
	get_parent().add_child(monsterPowerRelease)
	monsterPowerRelease.set_global_position(monster.get_global_position())
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_powerReleaseTimer_timeout():
	get_node("powerReleaseTimer").set_wait_time(rand_range(.5, 3))
	power_release()


func _on_monsterGroupMoveTimer_timeout():
	
	var border = false
	
	for monster in get_node("monsters").get_children():
		#Change the monster frame from the function next_frame() in the monster script
		monster.next_frame()
		if monster.get_global_position().x > 170 and direction > 0:
			direction = -1
			border = true
		if monster.get_global_position().x < 12 and direction < 0:
			direction = 1
			border = true
			
	if border:
		translate(Vector2(0, 8))
		if get_node("monsterGroupMoveTimer").get_wait_time() > .3:
			get_node("monsterGroupMoveTimer").set_wait_time(get_node("monsterGroupMoveTimer").get_wait_time() - .05)
	else:
		translate(SPEED * direction)

func on_monster_destroyed(monster):
	var monsterExplosion = previousMonsterExplosion.instance()
	get_parent().add_child(monsterExplosion)
	monsterExplosion.set_global_position(monster.get_global_position())
