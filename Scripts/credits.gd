extends Control

@onready var creditsText: Label = $"Made By"

func _ready() -> void:
	var screenSize = get_viewport_rect().size
	
	creditsText.position.x = (screenSize.x - creditsText.size.x) / 2.0
	creditsText.position.y = screenSize.y

	var target = (get_viewport_rect().size.y - creditsText.size.y) / 2.0

	var tween = create_tween()
	tween.set_trans(Tween.TRANS_QUAD)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(creditsText, "position:y", target + -175, 5.0)

func _process(_delta) -> void:
	if Input.is_action_just_pressed("Escape"):
			get_tree().quit()
