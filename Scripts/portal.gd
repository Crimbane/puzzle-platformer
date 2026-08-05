extends Area2D

var portalPosition: Vector2
var teleportTimer: = 5
var teleportCooldown: = 4

var tween

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

@onready var soundPortalUse: AudioStreamPlayer2D = $"Portal Use"
@onready var soundPortalTeleport: AudioStreamPlayer2D = $"Portal Teleport"
@onready var soundPortalStartup: AudioStreamPlayer2D = $"Portal Startup"


func _ready() -> void:
	body_entered.connect(_on_body_entered)
	portalPosition = global_position

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		#disabling collision did not work. Disabling monitoring stops Area2D from listening to more events
		set_deferred("monitoring", false)
		
		resetTween()
		tween.tween_method(set_rotation_degrees, 0.0, 360.0, teleportTimer)
		$AnimatedSprite2D.speed_scale = 4
		soundPortalStartup.play()
		soundPortalUse.play()
		
		await get_tree().create_timer(teleportTimer).timeout
		body.teleport.emit(portalPosition)
		$AnimatedSprite2D.speed_scale = 1
		soundPortalUse.stop()
		soundPortalTeleport.play()
		
		resetTween()
		tween.tween_property(self, "scale", Vector2(), 0.01) # self or $AnimatedSprite2D works
		await get_tree().create_timer(0.01).timeout
		resetTween()
		tween.tween_property(self, "scale", Vector2(1,1), teleportCooldown).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
		
		await get_tree().create_timer(teleportCooldown).timeout
		
		set_deferred("monitoring", true)

func resetTween() -> void:
	if tween:
		tween.kill()
	tween = create_tween()
