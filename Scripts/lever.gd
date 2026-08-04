extends Area2D

@export var boxes: Array[RigidBody2D]
var boxPositions: Array[Vector2]

var onLever = false

@onready var soundLeverPull: AudioStreamPlayer2D = $"Lever Pull"


func _ready() -> void:
	for box in boxes:
		if box != null:
			boxPositions.append(Vector2(box.position.x, box.position.y))
		

func _on_lever_interacted() -> void:
	if $Timer.is_stopped():
		$Timer.start()
		$Lever.flip_h = true
		$Label.visible = false
		soundLeverPull.play()
		for box in boxes:
			if box != null:
				var i = boxes.find(box)
				box.position = boxPositions[i]

func _on_body_entered(_body: Node2D) -> void:
	onLever = true
	if $Timer.is_stopped():
		$Label.visible = true


func _on_body_exited(_body: Node2D) -> void:
	onLever = false
	$Label.visible = false


func _on_timer_timeout() -> void:
	$Lever.flip_h = false
	if onLever:
		$Label.visible = true
