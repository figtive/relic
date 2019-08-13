extends Node


func _ready():
	$Guard.active = true
	$Camera2D.target($Guard)

func _process(delta):
	$GUI/LabelX.text = "dx: %8.2f" % $Guard.velocity.x
	$GUI/LabelY.text = "dy: %8.2f" % $Guard.velocity.y
	
	if Input.is_key_pressed(KEY_1):
		$Guard.active = true
		$Player.active = false
		$Camera2D.target($Guard)
	if Input.is_key_pressed(KEY_2):
		$Guard.active = false
		$Player.active = true
		$Camera2D.target($Player)
