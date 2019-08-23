extends StaticBody2D

export(GameManager.KeyType) var key_type
export(Texture) var texture

export(bool) var open
export(bool) var single_use

onready var detector = $Area2D

func _ready():
	pass
#	$Sprite.texture = texture
#	if not detector.is_connected("body_entered",  self, "open_door"):
#		print(name + " connect open")
#		detector.connect("body_entered", self, "open_door")
#	if not detector.is_connected("body_exited",  self, "close_door"):
#		print(name + " connect close")
#		detector.connect("body_exited", self, "close_door")

func open_door(body):
	if GameManager.current_level.has_key(body, key_type) and not open:
		open = true
		print(name + " opening")
		$AnimationPlayer.play("Open")

func close_door(body):
	if not single_use and open:
		open = false
		print(name + " closing")
		$AnimationPlayer.play_backwards("Open")