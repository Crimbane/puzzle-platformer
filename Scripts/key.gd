extends Area2D

@onready var shineSprite: Sprite2D = $"Key sprite/Shine"

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	startShineAnimation()

func _on_body_entered(body: Node2D) -> void:
	# Check if the thing that touched the spike is the Player
	if body.is_in_group("Player"):
		body.keyPickup.emit() 
		queue_free() # Deletes Node at end of frame

func startShineAnimation():	
	var tween = create_tween()
	tween.tween_property(shineSprite, "position:x", -50, 0)
	tween.tween_property(shineSprite, "rotation_degrees", -45, 0)
	tween.tween_property(shineSprite, "position:x", 50, 1).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	
	tween.parallel().tween_property(shineSprite, "modulate:a", 0.8, 0.4) # changes alpha to fade in
	tween.parallel().tween_property(shineSprite, "modulate:a", 0.0, 0.4).set_delay(0.6) # fade out
	
	tween.tween_interval(1.2)
	tween.set_loops()
