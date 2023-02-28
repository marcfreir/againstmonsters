tool

extends Area2D

export(int, "A", "B", "C") var type = 0 setget set_type

var score = 0
var frame = 0
var monsterSprite

#Signal for the destroyed monster
signal animation_destroyed(object)

# List of all types of monsters
var attributes = [
	{
		monsterSprite = preload("res://sprites/monsterA_sheet.png"),
		score = 30
	},
	{
		monsterSprite = preload("res://sprites/monsterB_sheet.png"),
		score = 20
	},
	{
		monsterSprite = preload("res://sprites/monsterC_sheet.png"),
		score = 10
	}
]

# Called when the node enters the scene tree for the first time.
func _ready():
	var attribute = attributes[type]
	get_node("monsterSprite").set_texture(attribute.monsterSprite)
	score = attribute.score

func _draw():
	var attribute = attributes[type]
	get_node("monsterSprite").set_texture(attribute.monsterSprite)
	score = attribute.score
	
func set_type(value):
	type = value
	if is_inside_tree() and Engine.editor_hint:
		update()

func destroy(object):
	#Indicates the monster was destroyed
	emit_signal("animation_destroyed", self)
	queue_free()
	
# Animate monsters sprites
func next_frame():
	if frame == 0:
		frame = 1
	else:
		frame = 0
	get_node("monsterSprite").set_frame(frame)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_monster_area_entered(area):
	if area.has_method("destroy"):
		area.destroy(self)
