extends AnimatableBody2D

var opened = false


func _on_button_pressed() -> void:
	var tween = create_tween()
	if not opened:
		tween.tween_property(self,"position:y", self.position.y-150, 1)
		await tween.finished
		opened = true


func _on_button_unpressed() -> void:
	var tween = create_tween()
	if opened:
		tween.tween_property(self,"position:y", self.position.y+150, 1)
		await tween.finished
		opened = false
