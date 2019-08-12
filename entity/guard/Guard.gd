extends KinematicBody2D

enum Movement {IDLE, WALK_RIGHT, WALK_LEFT, JUMP_RIGHT, JUMP_LEFT, FALL_R}

const GRAVITY = 800.0
const WALK_SPEED = 180

var current_movement
var velocity = Vector2()

func _ready():
	current_movement = update_animation(Movement.IDLE)

func _physics_process(delta):
	if is_on_floor():
		velocity.y = 0
	else:
		velocity.y += delta * GRAVITY
		
	var new_movement
	var go_left = Input.is_action_pressed("ui_left")
	var go_right = Input.is_action_pressed("ui_right")
	var go_jump = Input.is_action_pressed("ui_up")

	
	if not go_left and go_right:
		new_movement = Movement.WALK_RIGHT
		velocity.x = WALK_SPEED
	elif go_left and not go_right:
		new_movement = Movement.WALK_LEFT
		velocity.x = -WALK_SPEED
	elif not go_left and not go_right:
		new_movement = Movement.IDLE
		velocity.x = 0

	current_movement = update_animation(new_movement)
	move_and_slide(velocity, Vector2(0, -1))
	
func update_animation(state):
	var state_machine = $AnimationTree.get("parameters/playback")
	if current_movement != state:
		match state:
			Movement.IDLE:
				state_machine.travel("Idle")
			Movement.WALK_RIGHT:
				state_machine.travel("WalkRight")
			Movement.WALK_LEFT:
				state_machine.travel("WalkLeft")
	return state
		
