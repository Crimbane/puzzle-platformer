extends Area2D

var randomNumber = RandomNumberGenerator.new()
var spriteNumberSelector
@onready var soundBlood: AudioStreamPlayer2D = $"Blood Sound"
@onready var soundBloodBig: AudioStreamPlayer2D = $"Big Blood Sound"


func _ready() -> void:
	body_entered.connect(_on_body_entered)
	spriteNumberSelector = randomNumber.randi_range(1, 2)

func _on_body_entered(body: Node2D) -> void:
	# Check if the thing that touched the spike is the Player
	if body.is_in_group("Player"):
		# Trigger the hit signal directly on the player
		body.hit.emit() 
		bloodSpikes()

func bloodSpikes() -> void:
	soundBlood.play()
	if $AnimatedSprite2D.animation == "blood":
		$AnimatedSprite2D.animation = "big blood"
		soundBloodBig.play()
		return
	elif $AnimatedSprite2D.animation == "blood2":
		$AnimatedSprite2D.animation = "big blood 2"
		soundBloodBig.play()
		return
		
	if spriteNumberSelector == 1:
		$AnimatedSprite2D.animation = "blood"
	elif spriteNumberSelector == 2:
		$AnimatedSprite2D.animation = "blood2"
