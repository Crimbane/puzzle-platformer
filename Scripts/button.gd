extends Area2D


func _on_body_entered(body: Node2D) -> void:
	print(body)
	if body == RigidBody2D:
		print("entered")


func _on_body_exited(body: Node2D) -> void:
	if body == RigidBody2D:
		print("exited")
