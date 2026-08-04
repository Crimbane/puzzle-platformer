@tool
extends Area2D

#signal button_pressed(closedPosition, openedPosition)
#signal button_unpressed(closedPosition, openedPosition)

@export var platforms: Array[StaticBody2D]
@export var doors: Array[AnimatableBody2D]
var doorPositions: Array[Vector2]

@export_enum("Red", "Blue") var buttonColor: String:
	set(value):
		buttonColor = value
		updateSprite()

var count = 0
var entered = false

func _ready() -> void:
	updateSprite()
	
	for door in doors:
		if door != null:
			#self.button_pressed.connect(door._on_button_pressed)
			#self.button_unpressed.connect(door._on_button_unpressed)
			doorPositions.append(Vector2(door.position.y, door.position.y-128))
			if door.inverted && not Engine.is_editor_hint():
				door.position.y -= 128

func _on_body_entered(body: Node2D) -> void:
	if buttonColor == "Red":
		if body.is_in_group("Boxes"):
			count += 1
			if not entered && count >= 1:
				entered = true
				$AnimatedSprite2D.frame = 1
				for door in doors:
					if door != null:
						var i = doors.find(door)
						door.on_button_pressed(doorPositions[i].x, doorPositions[i].y)
	elif buttonColor == "Blue":
		if body.is_in_group("Player"):
			if not entered:
				entered = true
				$AnimatedSprite2D.frame = 1
				for platform in platforms:
					if platform != null:
						platform.visible = false
						platform.collision_layer = 0


func _on_body_exited(body: Node2D) -> void:
	if buttonColor == "Red":
		if body.is_in_group("Boxes"):
			count -= 1
			if entered && count < 1:
				entered = false
				$AnimatedSprite2D.frame = 0
				for door in doors:
					if door != null:
						var i = doors.find(door)
						door.on_button_unpressed(doorPositions[i].x, doorPositions[i].y)
	elif buttonColor == "Blue":
		if body.is_in_group("Player"):
			if entered:
				entered = false
				$AnimatedSprite2D.frame = 0
				for platform in platforms:
					if platform != null:
						platform.visible = true
						platform.collision_layer = 1

func updateSprite() -> void:
	var animatedSprite = get_node_or_null("AnimatedSprite2D")
	if animatedSprite:
		if buttonColor == "Red":
			animatedSprite.animation = "red"
		elif buttonColor == "Blue":
			animatedSprite.animation = "blue"
