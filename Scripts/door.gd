extends AnimatableBody2D

@export var inverted: bool
var opened = false


func on_button_pressed(closedPosition, openedPosition) -> void:
	if not opened:
		opened = true
		if not inverted:
			var tween = create_tween()
			tween.tween_property(self,"position:y", openedPosition, 0.5)
		else:
			var tween = create_tween()
			tween.tween_property(self,"position:y", closedPosition, 0.5)


func on_button_unpressed(closedPosition, openedPosition) -> void:
	if opened:
		opened = false
		if not inverted:
			var tween = create_tween()
			tween.tween_property(self,"position:y", closedPosition, 0.5)
		else:
			var tween = create_tween()
			tween.tween_property(self,"position:y", openedPosition, 0.5)
