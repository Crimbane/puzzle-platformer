@tool
extends Area2D

var randomNumber = RandomNumberGenerator.new()
var spriteNumberSelector
@onready var soundBlood: AudioStreamPlayer2D = $"Blood Sound"
@onready var soundBloodBig: AudioStreamPlayer2D = $"Big Blood Sound"

@export_enum("Normal", "Blood", "Blood2", "Big blood", "Big blood2") var spikeSprite: String = "Normal":
	set(value):
		spikeSprite = value
		updateSprite()

func _ready() -> void:
	if VolumeSettings != null:
		soundBlood.volume_db = VolumeSettings.soundVolume
		soundBloodBig.volume_db = VolumeSettings.soundVolume
	body_entered.connect(_on_body_entered)
	spriteNumberSelector = randomNumber.randi_range(1, 2)
	updateSprite()

func _on_body_entered(body: Node2D) -> void:
	# Check if the thing that touched the spike is the Player
	if body.is_in_group("Player"):
		# Trigger the hit signal directly on the player
		body.hit.emit() 
		bloodSpikes()

func bloodSpikes() -> void:
	soundBlood.play()
	if $AnimatedSprite2D.animation == "big blood" or $AnimatedSprite2D.animation == "big blood2":
		soundBloodBig.play()
		
	if $AnimatedSprite2D.animation == "blood":
		$AnimatedSprite2D.animation = "big blood"
		soundBloodBig.play()
		return
	elif $AnimatedSprite2D.animation == "blood2":
		$AnimatedSprite2D.animation = "big blood 2"
		soundBloodBig.play()
		return
		
	if spriteNumberSelector == 1 and $AnimatedSprite2D.animation == "default":
		$AnimatedSprite2D.animation = "blood"
	elif spriteNumberSelector == 2 and $AnimatedSprite2D.animation == "default":
		$AnimatedSprite2D.animation = "blood2"

func updateSprite() -> void:
	var animatedSprite = get_node_or_null("AnimatedSprite2D")
	if animatedSprite:
		if spikeSprite == "Blood":
			$AnimatedSprite2D.animation = "blood"
		elif spikeSprite == "Blood2":
			$AnimatedSprite2D.animation = "blood2"
		elif spikeSprite == "Big blood":
			$AnimatedSprite2D.animation = "big blood"
		elif spikeSprite == "Big blood2":
			$AnimatedSprite2D.animation = "big blood 2"
