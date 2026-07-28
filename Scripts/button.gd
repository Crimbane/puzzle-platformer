extends Area2D

signal button_pressed(door)
signal button_unpressed(door)

@export var door: AnimatableBody2D

var count = 0
var entered = false


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Boxes"):
		count += 1
		if not entered && count >= 1:
			entered = true
			button_pressed.emit(door)
			$AnimatedSprite2D.frame = 1


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Boxes"):
		count -= 1
		if entered && count < 1:
			entered = false
			button_unpressed.emit(door)
			$AnimatedSprite2D.frame = 0
