extends AnimatableBody2D

var opened = false


func _on_button_pressed(door) -> void:
	var tween = create_tween()
	if not opened && door == self:
		tween.tween_property(self,"position:y", self.position.y-150, 0.5)
		await tween.finished
		opened = true


func _on_button_unpressed(door) -> void:
	var tween = create_tween()
	if opened && door == self:
		tween.tween_property(self,"position:y", self.position.y+150, 0.5)
		await tween.finished
		opened = false
