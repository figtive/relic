extends Area2D

export(GameManager.KeyType) var key_type
export(Texture) var texture

func _ready():
	$Sprite.texture = texture
	if not is_connected("body_entered", self, "claim"):
		connect("body_entered", self, "claim")
	
func claim(body):
	GameManager.current_level.claim_key(body, key_type)
	hide()
