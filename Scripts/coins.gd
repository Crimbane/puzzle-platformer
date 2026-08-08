extends Area2D

@onready var audioSound: AudioStreamPlayer2D = $AudioStreamPlayer2D


func _ready() -> void:
	if VolumeSettings != null:
		audioSound.volume_db = VolumeSettings.soundVolume
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
			audioSound.play()
