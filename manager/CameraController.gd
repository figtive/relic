extends Camera2D

export(NodePath) var target_path = null

func target(node: Node2D):
	target_path = node.get_path()

func _physics_process(delta):
	if target_path != null and get_node(target_path) != null:
		transform.origin = (get_node(target_path) as Node2D).transform.get_origin()
