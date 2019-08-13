extends Node

enum KeyType {Red, Green, Blue, Yellow, Orange, Purple}
enum Level {MAIN_MENU, LEVEL_1, LEVEL_2}

const LevelPath = {
	Level.MAIN_MENU: "",
	Level.LEVEL_1: "",
	Level.LEVEL_2: "",
}

var current_level: Node = null

func _ready():
	var root = get_tree().get_root()
	current_level = root.get_child(root.get_child_count() - 1)

func set_level(level):
	match level:
		Level.MAIN_MENU:
			call_deferred("_deferred_scene_change", LevelPath[Level.MAIN_MENU])
			print_debug("GameManager :: Changing scene to Main Menu")
		Level.LEVEL_1:
			call_deferred("_deferred_scene_change", LevelPath[Level.LEVEL_1])
			print_debug("GameManager :: Changing scene to Level 1")
		Level.LEVEL_2:
			call_deferred("_deferred_scene_change", LevelPath[Level.LEVEL_2])
			print_debug("GameManager :: Changing scene to Level 2")
		_:
			printerr("GameManager :: Unknown level!")
			
func _deferred_scene_change(path):
	current_level.free()
	var s = ResourceLoader.load(path)
	current_level = s.instance()
	get_tree().get_root().add_child(current_level)
	get_tree().set_current_scene(current_level)