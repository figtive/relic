extends StaticBody2D

export(GameManager.KeyType) var key_type
export(Texture) var texture

export(bool) var open
export(bool) var single_use

onready var detector = $Area2D

func _ready():
#	$Sprite.texture = texture
	if not detector.is_connected("body_entered",  self, "open_door"):
		detector.connect("body_entered", self, "open_door")
	if not detector.is_connected("body_exited",  self, "close_door"):
		detector.connect("body_exited", self, "close_door")

func open_door(body):
	if GameManager.current_level.has_key(body, key_type) and not open:
		open = true
		$AnimationPlayer.play("Open")

func close_door(body):
	if not single_use and open:
		open = false
		$AnimationPlayer.play_backwards("Open")