extends AnimatableBody2D

var opened = false


func _on_button_pressed(door, _closedPosition, openedPosition) -> void:
	var tween = create_tween()
	if not opened && door == self:
		opened = true
		tween.tween_property(self,"position:y", openedPosition, 0.5)


func _on_button_unpressed(door, closedPosition, _openedPosition) -> void:
	var tween = create_tween()
	if opened && door == self:
		opened = false
		tween.tween_property(self,"position:y", closedPosition, 0.5)
