extends KinematicBody2D

enum Movement {IDLE, WALK_RIGHT, WALK_LEFT, JUMP, FALL}

export(float) var JUMP_POWER = -500.0
export(float) var WALK_ACCEL = 30
export(float) var AIR_FRICTION = 0.05
export(float) var GROUND_FRICTION = 0.25
export(float) var MAX_SPEED_X = 400
export(float) var MAX_SPEED_Y = 700

var current_movement
var velocity = Vector2()

export(bool) var active = false

func _ready():
	$AnimationTree.set_active(true)
	update_animation(Movement.IDLE)

func _physics_process(delta):
	var idling = false
	var go_left = Input.is_action_pressed("ui_left") and active
	var go_right = Input.is_action_pressed("ui_right") and active
	var go_jump = Input.is_action_just_pressed("ui_up") and active
	
	
	velocity.y += GameManager.current_level.GRAVITY
	
	if not go_left and go_right:
		update_animation(Movement.WALK_RIGHT)
		velocity.x = velocity.x + WALK_ACCEL
	elif go_left and not go_right:
		update_animation(Movement.WALK_LEFT)
		velocity.x = velocity.x - WALK_ACCEL
	else:
		update_animation(Movement.IDLE)
		idling = true
	
	if is_on_floor():
		if go_jump:
			velocity.y = JUMP_POWER
		if idling:
			velocity.x = lerp(velocity.x, 0, GROUND_FRICTION)
	else:
		if velocity.y < 0:
			update_animation(Movement.JUMP)
		else:
			update_animation(Movement.FALL)
		if idling:
			velocity.x = lerp(velocity.x, 0, AIR_FRICTION)
	
	velocity.x = clamp(velocity.x, -MAX_SPEED_X, MAX_SPEED_X)
	velocity.y = clamp(velocity.y, -MAX_SPEED_Y, MAX_SPEED_Y)
	velocity = move_and_slide(velocity, Vector2(0, -1))
	
func update_animation(state):
	var state_machine = $AnimationTree.get("parameters/playback")
	match state:
		Movement.IDLE:
			state_machine.travel("Idle")
		Movement.WALK_RIGHT:
			$Sprite.flip_h = false
			state_machine.travel("Walk")
		Movement.WALK_LEFT:
			$Sprite.flip_h = true
			state_machine.travel("Walk")
		Movement.JUMP:
			state_machine.travel("Jump")
		Movement.FALL:
			state_machine.travel("Fall")
	current_movement = state
		
