extends Area2D

signal button_pressed(door, closedPosition, openedPosition)
signal button_unpressed(door, closedPosition, openedPosition)

@export var doors: Array[AnimatableBody2D]
var doorPositions: Array[Vector2]

var count = 0
var entered = false

func _ready() -> void:
	for door in doors:
		doorPositions.append(Vector2(door.position.y, door.position.y-128))
		if door.inverted:
			door.position.y -= 128

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Boxes"):
		count += 1
		if not entered && count >= 1:
			entered = true
			$AnimatedSprite2D.frame = 1
			for door in doors:
				var i = doors.find(door)
				button_pressed.emit(door, doorPositions[i].x, doorPositions[i].y)


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Boxes"):
		count -= 1
		if entered && count < 1:
			entered = false
			$AnimatedSprite2D.frame = 0
			for door in doors:
				var i = doors.find(door)
				button_unpressed.emit(door, doorPositions[i].x, doorPositions[i].y)
