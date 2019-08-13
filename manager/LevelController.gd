extends Node

export(float, 100) var GRAVITY = 10
export(Array, NodePath) var players

var key_owner = {}

func _ready():
	$Guard.active = true
	$Camera.target($Guard)

func _process(delta):
	$GUI/LabelX.text = "dx: %8.2f" % $Guard.velocity.x
	$GUI/LabelY.text = "dy: %8.2f" % $Guard.velocity.y
	
	if Input.is_key_pressed(KEY_1):
		$Guard.active = true
		$Player.active = false
		$Camera.target($Guard)
	if Input.is_key_pressed(KEY_2):
		$Guard.active = false
		$Player.active = true
		$Camera.target($Player)

func claim_key(player, key_type):
	key_owner[player] = key_type

func has_key(player, key_type):
	if key_owner.has(player):
		return key_owner[player] == key_type
	return false
