extends Area2D

var count = 0
var entered = false


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Boxes"):
		count += 1
		if not entered && count >= 1:
			entered = true
			print("entered")


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Boxes"):
		count -= 1
		if entered && count < 1:
			entered = false
			print("exited")
