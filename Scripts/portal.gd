extends Area2D

var portalPosition: Vector2
var teleportTimer: = 5
var teleportCooldown: = 2

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	portalPosition = global_position

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		#disabling collision did not work. Disabling monitoring stops Area2D from listening to more events
		set_deferred("monitoring", false)
		
		var tween = create_tween()
		tween.tween_method(set_rotation_degrees, 0.0, 360.0, teleportTimer)
		
		#$AnimatedSprite2D.speed_scale = 10
		
		await get_tree().create_timer(teleportTimer).timeout
		body.teleport.emit(portalPosition)
		
		#$AnimatedSprite2D.speed_scale = 1
		await get_tree().create_timer(teleportCooldown).timeout
		
		set_deferred("monitoring", true)
