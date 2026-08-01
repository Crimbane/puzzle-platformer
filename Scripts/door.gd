extends AnimatableBody2D

@export var inverted: bool
var opened = false


func _on_button_pressed(door, closedPosition, openedPosition) -> void:
	if not opened && door == self:
		opened = true
		if not inverted:
			var tween = create_tween()
			tween.tween_property(self,"position:y", openedPosition, 0.5)
		else:
			var tween = create_tween()
			tween.tween_property(self,"position:y", closedPosition, 0.5)


func _on_button_unpressed(door, closedPosition, openedPosition) -> void:
	if opened && door == self:
		opened = false
		if not inverted:
			var tween = create_tween()
			tween.tween_property(self,"position:y", closedPosition, 0.5)
		else:
			var tween = create_tween()
			tween.tween_property(self,"position:y", openedPosition, 0.5)
