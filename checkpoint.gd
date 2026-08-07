extends Area2D

var checkpointPosition: Vector2

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	checkpointPosition = global_position
	$Label.queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body.checkpoint.emit(checkpointPosition)
