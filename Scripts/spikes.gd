extends Area2D

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	# Check if the thing that touched the spike is the Player
	if body.is_in_group("Player"):
		# Trigger the hit signal directly on the player
		body.hit.emit() 
