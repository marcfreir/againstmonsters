extends Node2D

const SPEED = Vector2(6, 0)

var previousMonsterPowerRelease = preload("res://scenes/monsterPower.tscn")
var previousMonsterExplosion = preload("res://scenes/monsterExplosion.tscn")
var previousMotherShip = preload("res://scenes/motherShip.tscn")

var direction = 1

signal monster_down(object)
signal monster_ready
signal area_conquered
signal victory


# Called when the node enters the scene tree for the first time.
func _ready():
	#get_node("powerReleaseTimer").start()
	restart_motherShipTimer()
	for monster in get_node("monsters").get_children():
		monster.hide()
		monster.connect("animation_destroyed", self, "on_monster_destroyed")
		
	for monster in get_node("monsters").get_children():
		get_node("pauseMonsterTimer").start()
		yield(get_node("pauseMonsterTimer"), "timeout")
		monster.show()
	
	emit_signal("monster_ready")
	start_all()


func power_release():
	var numMonsters = get_node("monsters").get_child_count()
	if numMonsters > 0:
		var monster = get_node("monsters").get_child(randi() % numMonsters)
		var monsterPowerRelease = previousMonsterPowerRelease.instance()
		get_parent().add_child(monsterPowerRelease)
		monsterPowerRelease.set_global_position(monster.get_global_position())
		$monsterPowerReleaseAudioStreamPlayer.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_powerReleaseTimer_timeout():
	get_node("powerReleaseTimer").set_wait_time(rand_range(.5, 3))
	power_release()

func _on_monsterGroupMoveTimer_timeout():
	
	$monstersRunAudioStreamPlayer.play()
	
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
		if monster.get_global_position().y > 260:
			emit_signal("area_conquered")
			
	if border:
		translate(Vector2(0, 8))
		if get_node("monsterGroupMoveTimer").get_wait_time() > .3:
			get_node("monsterGroupMoveTimer").set_wait_time(get_node("monsterGroupMoveTimer").get_wait_time() - .05)
	else:
		translate(SPEED * direction)

func on_monster_destroyed(monster):
	$monsterExplosionAudioStreamPlayer.play()
	emit_signal("monster_down", monster)
	var monsterExplosion = previousMonsterExplosion.instance()
	get_parent().add_child(monsterExplosion)
	monsterExplosion.set_global_position(monster.get_global_position())
	
	#Verify the last one monster and give the victory to the player
	if get_node("monsters").get_child_count() == 1:
		stop_all()
		emit_signal("victory")


func _on_motherShipTimer_timeout():
	var motherShip = previousMotherShip.instance()
	motherShip.connect("animation_destroyed", self, "on_monster_destroyed")
	get_parent().add_child(motherShip)
	restart_motherShipTimer()

func restart_motherShipTimer():
	#Get the motherShipTimer and change the time rondomly (from 6 to 12 sec), then...
	get_node("motherShipTimer").set_wait_time(rand_range(6, 12))
	#...restart the motherShipTimer
	get_node("motherShipTimer").start()

func stop_all():
	get_node("motherShipTimer").stop()
	get_node("powerReleaseTimer").stop()
	get_node("monsterGroupMoveTimer").stop()

func start_all():
	get_node("motherShipTimer").start()
	get_node("powerReleaseTimer").start()
	get_node("monsterGroupMoveTimer").start()

