extends KinematicBody2D
# defines GRAVITY
# `export` makes your variable editable in the editor
# `var GRAVITY = 10` defines a variable named GRAVITY and assign it 10
export var GRAVITY = 10
# set the maximum falling speed per frame
export var MAX_FALLING_SPEED = 15
# MOVE_SPEED
export var MOVE_SPEED = 5
export var MOVE_SPEED_TIME_NEEDED = .15
var move_step = 0
export var DECELERATION_TIME_NEEDED = .15
var dec_step = 0
# jump power
export var MAX_JUMP_POWER = 5
export var MIN_JUMP_POWER = 2
export var MAX_AIR_JUMP_POWER = 3
export var MIN_AIR_JUMP_POWER = 1
export var MAX_AIR_JUMP_COUNT = 0
# store the player velocity
var velocity = Vector2()
# store status of jump input
var is_jump_pressed = false
# store status if last frame grounded
var last_frame_grounded = false
#store jump counter
var air_jump_count = 0
var facing_dir = 1
var last_anim = ""
onready var anim = get_node("AnimationPlayer")
onready var sprite = get_node("Sprite")
# Called when the node is "ready", that means called when the game started.
# Use this function for initialize
func _ready():
	move_step = MOVE_SPEED / MOVE_SPEED_TIME_NEEDED
	dec_step = MOVE_SPEED / DECELERATION_TIME_NEEDED
	last_anim = anim.get_current_animation()
	# makes `_fixed_process(delta)` running
	set_fixed_process(true)
# Called during the fixed processing step of the main loop.
# Fixed processing means that the frame rate is synced to the physics,
# i.e. the delta variable should be constant.
# only active when set_fixed_process(true) is called
func _fixed_process(delta):
	# make a Vector2 variable movement and add gravity into y axis
	var movement = Vector2(velocity.x, velocity.y + GRAVITY * delta)
	#input
	var right_input = Input.is_action_pressed("right")
	var left_input = Input.is_action_pressed("left")
	#var jump_input = Input.is_action_pressed("jump")
	var jump_input = false
	var moonwalk = Input.is_action_pressed("moonwalk")
	var macarena = Input.is_action_pressed("macarena")
	var breakdance = Input.is_action_pressed("breakdance")
	var estrela = Input.is_action_pressed("estrela")
	var rebolada = Input.is_action_pressed("rebolada")
	var travar = Input.is_action_pressed("travar")
	var queda = Input.is_action_pressed("queda")

	
	#Apply the horizontal movement
	if right_input:
		movement.x += move_step * delta
	elif left_input:
		movement.x -= move_step * delta
	elif movement.x != 0:
		#get the direction of movement
		var _dir = sign(movement.x)
		#calculate deceleration amount and direction
		var _dec = _dir * -1 * dec_step * delta
		# apply to movement
		movement.x += _dec
		# stop it when reached 0
		if _dir == 1 && movement.x < 0:
			movement.x = 0
		elif _dir == -1 && movement.x > 0:
			movement.x = 0
	#if the movement.x more that max_speed, gap it
	if abs(movement.x) > MOVE_SPEED:
		movement.x = sign(movement.x) * MOVE_SPEED
	#Apply jumping
	if jump_input:
		if !is_jump_pressed && last_frame_grounded:
			movement.y = -MAX_JUMP_POWER
		elif !is_jump_pressed && !last_frame_grounded && air_jump_count < MAX_AIR_JUMP_COUNT:
			movement.y = -MAX_AIR_JUMP_POWER
			air_jump_count += 1
		is_jump_pressed = true
	elif !jump_input && is_jump_pressed:
		if air_jump_count != 0 && movement.y < -MIN_AIR_JUMP_POWER:
			movement.y = -MIN_AIR_JUMP_POWER
		elif movement.y < -MIN_JUMP_POWER:
			movement.y = -MIN_JUMP_POWER
		is_jump_pressed = false
	# set the velocity = movement
	velocity = movement
	# set the maximum falling speed
	if velocity.y > MAX_FALLING_SPEED:
		velocity.y = MAX_FALLING_SPEED
	
	
	var new_anim = "idle"
	sprite.set_flip_h(facing_dir == 1)
	if last_frame_grounded:
		if velocity.x == 0 && travar:
			new_anim = "travado"
			if not get_node("SamplePlayer").is_active():
				get_node("SamplePlayer").play("IssoOAgoraQueBonito")
				get_node("SamplePlayer").play("Boo1")
		elif anim.get_current_animation() == "travado" && anim.get_pos() < 2:
			new_anim = "travado"
			velocity.x = 0
		elif velocity.x == 0 && queda:
			new_anim = "queda"
			if not get_node("SamplePlayer").is_active():
				get_node("SamplePlayer").play("VideoCassetadaAoVivo")
				get_node("SamplePlayer").play("Boo1")
				get_node("SamplePlayer").play("ScreamOfJoy")
		elif anim.get_current_animation() == "queda" && anim.get_pos() < 2:
			new_anim = "queda"
			velocity.x = 0
		if estrela:
			new_anim = "estrela"
			if not get_node("SamplePlayer").is_active():
				get_node("SamplePlayer").play("OlhaMeu")
				get_node("SamplePlayer").play("CrowdCheer")
				get_node("SamplePlayer").play("Applause1")
		elif anim.get_current_animation() == "estrela" && anim.get_pos() < 0.85:
			new_anim = "estrela"
			if facing_dir == 1:
				velocity.x = MOVE_SPEED
			else:
				velocity.x = -MOVE_SPEED
			sprite.set_flip_h(facing_dir == -1)
			global.termometro = global.termometro - 0.02
		elif breakdance:
			new_anim = "breakdance"
			if not get_node("SamplePlayer").is_active():
				get_node("SamplePlayer").play("OLokoMeu")
				get_node("SamplePlayer").play("CrowdCheer")
				get_node("SamplePlayer").play("Cheering")
		elif anim.get_current_animation() == "breakdance" && anim.get_pos() < 1.5:
			new_anim = "breakdance"
			sprite.set_flip_h(facing_dir == -1)
			global.termometro = global.termometro - 0.03
		elif velocity.x < 0 && moonwalk:
			new_anim = "moveright"
			if not get_node("SamplePlayer").is_active():
				get_node("SamplePlayer").play("OLoco")
				get_node("SamplePlayer").play("Applause2")
		elif velocity.x > 0 && moonwalk:
			new_anim = "moveright"
			if not get_node("SamplePlayer").is_active():
				get_node("SamplePlayer").play("PorraMeuAla")
				get_node("SamplePlayer").play("CrowdCheer")
		elif velocity.x > 0:
			new_anim = "moveleft"
		elif velocity.x < 0:
			new_anim = "moveleft"
		elif velocity.x == 0 && macarena:
			new_anim = "macarena"
			if not get_node("SamplePlayer").is_active():
				get_node("SamplePlayer").play("macarena")
				get_node("SamplePlayer").play("Applause2")
				get_node("SamplePlayer").play("MostraAiO")
		elif anim.get_current_animation() == "macarena" && anim.get_pos() < 4:
			new_anim = "macarena"
			sprite.set_flip_h(facing_dir == 1)
			global.termometro = global.termometro - 0.02
		elif velocity.x == 0 && rebolada:
			new_anim = "rebolada"
			if not get_node("SamplePlayer").is_active():
				get_node("SamplePlayer").play("QueFiguraHeinMeu")
				get_node("SamplePlayer").play("Cheering")
		elif anim.get_current_animation() == "rebolada" && anim.get_pos() < 1.5:
			new_anim = "rebolada"
			sprite.set_flip_h(facing_dir == 1)
			global.termometro = global.termometro - 0.02
		
	else:
		new_anim = "jumping"
	#apply animation
	if new_anim != last_anim:
		anim.play(new_anim)
		last_anim = new_anim
		
	# apply the movement by calling move(velocity) and store the remaining movement
	var remaining_movement = move(velocity)
	# collision handling
	if is_colliding():
		var normal = get_collision_normal()
		remaining_movement = normal.slide(remaining_movement)
		velocity = normal.slide(velocity)
		move(remaining_movement)
		# if normal is floor, then set as grounded
		if normal == Vector2(0, -1):
			last_frame_grounded = true
			air_jump_count = 0
	elif last_frame_grounded:
		last_frame_grounded = false
	if velocity.x != 0:
		facing_dir = sign(velocity.x)
func get_center_pos():
	return get_pos() + get_node("CollisionShape2D").get_pos()
