extends CharacterBody2D

#char sprite is 1080 / 8 = 135 pixels tall

signal hit
signal keyPickup
signal keyUsed
signal teleport(position)

const WALK_SPEED: = 200.0
const CROUCH_SPEED: = 100.0
var currentSpeed: = WALK_SPEED
const JUMP_VELOCITY: = -438.0 #increased from 400
var pushForce: = 3000
@onready var body: CharacterBody2D = get_node(".")

var initialPosition: Vector2
var keysInInventory: = 0

var crouch: = false
var inAir = false
var inAirTimerStarted = false

func _ready() -> void:
	initialPosition = global_position
	#hit.connect(_on_hit) # connected in editor
	keyPickup.connect(onKeyPickup)
	keyUsed.connect(onKeyUsed)
	teleport.connect(onTeleport)

func _process(delta):
	if crouch == false and inAir == false:
		$AnimatedSprite2D.offset.y = 0
		$Sprite2D.offset.y = 0
		if velocity.x > 0 or Input.is_action_pressed("Move Right"):
			$AnimatedSprite2D.animation = "walk"
			$AnimatedSprite2D.flip_h = false
		elif velocity.x < 0 or Input.is_action_pressed("Move Left"):
			$AnimatedSprite2D.animation = "walk"
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.animation = "idle"
	elif crouch == true:
		$AnimatedSprite2D.offset.y = 31.5
		$Sprite2D.offset.y = 155 * 2
		
		if velocity.x > 0 or Input.is_action_pressed("Move Right"):
			$AnimatedSprite2D.animation = "crouch walk"
			$AnimatedSprite2D.flip_h = false
		elif velocity.x < 0 or Input.is_action_pressed("Move Left"):
			$AnimatedSprite2D.animation = "crouch walk"
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.animation = "crouch idle"


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
		$AnimatedSprite2D.animation = "jump"
		if inAirTimerStarted == false:
			inAirTimerStarted = true
			get_tree().create_timer(0.1).timeout.connect(setInAir) # Coyote time
	elif is_on_floor():
		inAir = false
		inAirTimerStarted = false

	# Handle jump.
	if Input.is_action_just_pressed("Jump") and inAir == false:
		velocity.y = JUMP_VELOCITY
		
	
	if Input.is_action_just_pressed("Crouch"):
		$StandingCollision.disabled = true
		crouch = true
		$Sprite2D.scale *= 0.5
		currentSpeed = CROUCH_SPEED 
	
	if Input.is_action_just_released("Crouch"):
		$StandingCollision.disabled = false
		crouch = false
		$Sprite2D.scale *= 2.0
		currentSpeed = WALK_SPEED
	
	if Input.is_action_just_pressed("Go Down"):
		var col = $CheckForPlatform.get_collider()
		if col != null && col.is_in_group("Platforms"):
			position.y += 1

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("Move Left", "Move Right")
	if direction:
		velocity.x = direction * WALK_SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, WALK_SPEED)

	move_and_slide()
	
	if body.move_and_slide():
		for i in body.get_slide_collision_count():
			var col = body.get_slide_collision(i)
			if col.get_collider() is RigidBody2D:
				var box: RigidBody2D = col.get_collider()
				box.apply_central_force(col.get_normal() * -pushForce)

# Changed the script

#func _on_spikes_body_entered(body: Node2D) -> void:
#	hit.emit()

func setInAir() -> void:
	inAir = true

func _on_hit() -> void:
	global_position = initialPosition

func onKeyPickup() -> void:
	keysInInventory += 1
	if keysInInventory > 0:
		$Sprite2D.visible = true

func onKeyUsed():
	keysInInventory -= 1
	if keysInInventory < 1:
		$Sprite2D.visible = false

func onTeleport(portalPosition):
	global_position = portalPosition
