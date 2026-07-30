extends AnimatableBody2D

@onready var startPositionY = position.y
@onready var endPositionY = position.y-1985

func _ready() -> void:
	var tween = create_tween().set_loops().set_trans(Tween.TRANS_SINE).set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
	tween.tween_interval(2)
	tween.tween_property(self, "position:y", endPositionY, 5)
	tween.tween_interval(2)
	tween.tween_property(self, "position:y", startPositionY, 5)
