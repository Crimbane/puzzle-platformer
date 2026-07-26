extends Area2D

var entered = false


func _on_body_entered(_body: RigidBody2D) -> void:
	if not entered:
		entered = true
		print("entered")


func _on_body_exited(_body: RigidBody2D) -> void:
	if entered:
		entered = false
		print("exited")
