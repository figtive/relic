extends Node

export(float, 100) var GRAVITY = 10

var key_owner = {}

func _ready():
	$Player.active = true
	$Camera.target($Player)
	change_zone(false)

func _process(delta):
	$GUI/LabelX.text = "dx: %8.2f" % $Player.velocity.x
	$GUI/LabelY.text = "dy: %8.2f" % $Player.velocity.y
	
	if Input.is_key_pressed(KEY_1):
		change_zone(false)
	if Input.is_key_pressed(KEY_2):
		change_zone(true)

func change_zone(to_future):
	if to_future:
		$GUI/Zone.text = "zone: future"
		$Past.hide()
		$Future.show()
		$Past.set_global_scale(Vector2(0, 0))
		$Future.set_global_scale(Vector2(1, 1))
	else:
		$GUI/Zone.text = "zone: past"
		$Past.show()
		$Future.hide()
		$Past.set_global_scale(Vector2(1, 1))
		$Future.set_global_scale(Vector2(0, 0))

func claim_key(player, key_type):
	key_owner[player] = key_type

func has_key(player, key_type):
	if key_owner.has(player):
		return key_owner[player] == key_type
	return false
