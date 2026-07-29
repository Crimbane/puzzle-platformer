extends Area2D



func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		if body.keysInInventory > 0:
			body.keyUsed.emit() 
			
			#--change to second animation frame
			
			
			var tween = create_tween()
			tween.parallel().tween_property(self, "rotation_degrees", 45, 0.5)
			tween.parallel().tween_property(self, "position", position + Vector2(0, 2500), 5)
			tween.tween_callback(queue_free)
