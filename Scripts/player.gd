extends CharacterBody2D

#char sprite is 1080 / 8 = 135 pixels tall

signal hit

const SPEED = 200.0
const JUMP_VELOCITY = -438.0 #increased from 400
var pushForce = 3000
var initialPosition
@onready var body: CharacterBody2D = get_node(".")

func _ready() -> void:
	initialPosition = global_position

func _process(delta):
	
		
	if velocity.x > 0 or Input.is_action_pressed("Move Right"):
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_h = false
	elif velocity.x < 0 or Input.is_action_pressed("Move Left"):
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_h = true
	else:
		$AnimatedSprite2D.animation = "idle"


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("Move Left", "Move Right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

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


func _on_hit() -> void:
	global_position = initialPosition
