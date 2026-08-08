extends Area2D

@onready var audioSound: AudioStreamPlayer2D = $AudioStreamPlayer2D
@export var finalDoor: StaticBody2D


func _ready() -> void:
	if "soundVolume" in VolumeSettings:
		audioSound.volume_db = VolumeSettings.soundVolume
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		if body.keysInInventory > 0:
			body.keyUsed.emit() 
			audioSound.play(0.18)
			
			finalDoor.get_node("ClosedSprite").visible = false
			finalDoor.get_node("OpenedSprite").visible = true
			finalDoor.collision_layer = 0
			
			#$AnimatedSprite2D.animation = "open"
			#await get_tree().create_timer(0.7).timeout
			
			var tween = create_tween()
			tween.set_ease(Tween.EASE_OUT)
			tween.set_trans(Tween.TRANS_SINE)
			tween.tween_property(self, "position", position + Vector2(32, -30), .2)
			tween.parallel()
			tween.tween_property(self, "rotation_degrees", 60, .3)
			tween.set_ease(Tween.EASE_IN)
			tween.tween_property(self, "position", position + Vector2(45, 50), .3)
			tween.parallel()
			tween.tween_property(self, "rotation_degrees", 90, .3)
			tween.set_trans(Tween.TRANS_LINEAR)
			tween.tween_property(self, "rotation_degrees", 360, 2.5)
			tween.parallel()
			tween.tween_property(self, "position", position + Vector2(100, 2500), 6)
			tween.tween_callback(queue_free)
