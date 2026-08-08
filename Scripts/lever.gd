extends Area2D

@export var message: String
@export var callElevator: bool
@export var elevator: AnimatableBody2D
@export var boxes: Array[RigidBody2D]
var boxPositions: Array[Vector2]

var onLever = false

@onready var soundLeverPull: AudioStreamPlayer2D = $"Lever Pull"


func _ready() -> void:
	if "soundVolume" in VolumeSettings:
		soundLeverPull.volume_db = VolumeSettings.soundVolume
	$Label.text = message
	for box in boxes:
		if box != null:
			boxPositions.append(Vector2(box.position.x, box.position.y))
		

func _on_lever_interacted() -> void:
	if $Timer.is_stopped():
		$Timer.start()
		$Lever.flip_h = true
		$Label.visible = false
		soundLeverPull.play()
		
		if not callElevator:
			for box in boxes:
				if box != null:
					var i = boxes.find(box)
					box.position = boxPositions[i]
		else:
			elevator.moveElevator(true)

func _on_body_entered(_body: Node2D) -> void:
	onLever = true
	if $Timer.is_stopped():
		$Label.visible = true


func _on_body_exited(_body: Node2D) -> void:
	onLever = false
	$Label.visible = false


func _on_timer_timeout() -> void:
	$Lever.flip_h = false
	soundLeverPull.play()
	if onLever:
		$Label.visible = true
