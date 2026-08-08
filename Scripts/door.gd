extends AnimatableBody2D

@export var inverted: bool
var opened = false
var doorOpenTimer = 0.5

@onready var soundDoor: AudioStreamPlayer2D = $SoundDoor

func _ready() -> void:
	if "soundVolume" in VolumeSettings:
		soundDoor.volume_db = VolumeSettings.soundVolume


func on_button_pressed(closedPosition, openedPosition) -> void:
	if not opened:
		opened = true
		if not inverted:
			var tween = create_tween()
			soundDoor.play()
			tween.tween_property(self,"position:y", openedPosition, doorOpenTimer)
			await get_tree().create_timer(doorOpenTimer).timeout
			soundDoor.stop()
		else:
			var tween = create_tween()
			soundDoor.play()
			tween.tween_property(self,"position:y", closedPosition, doorOpenTimer)
			await get_tree().create_timer(doorOpenTimer).timeout
			soundDoor.stop()


func on_button_unpressed(closedPosition, openedPosition) -> void:
	if opened:
		opened = false
		if not inverted:
			var tween = create_tween()
			tween.tween_property(self,"position:y", closedPosition, 0.5)
		else:
			var tween = create_tween()
			tween.tween_property(self,"position:y", openedPosition, 0.5)
