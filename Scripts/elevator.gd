extends AnimatableBody2D

@onready var startPositionY = position.y
@onready var endPositionY = position.y-1985
var currentPosition
var tween: Tween
@export var invertedStartPosition = true # starts at top instead of bottom

@onready var soundButton: AudioStreamPlayer2D = $ElevatorButton
@onready var soundElevatorMoving: AudioStreamPlayer2D = $ElevatorMoving


func _ready() -> void:
	$Area2D.body_entered.connect(callElevator)
	currentPosition = startPositionY
	if invertedStartPosition == true:
		tween = create_tween()
		tween.tween_property(self, "position:y", endPositionY, 0.1)
		
		currentPosition = endPositionY

func moveElevator() -> void:
	if tween and tween.is_running():
		return
	
	if currentPosition == startPositionY:
		tween = create_tween().set_trans(Tween.TRANS_SINE).set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
		tween.tween_callback($Area2D/Sprite2D.hide)
		playElevatorSound()
		tween.tween_interval(2)
		tween.tween_property(self, "position:y", endPositionY, 5)
		tween.tween_callback($Area2D/Sprite2D.show)
		currentPosition = endPositionY
		
	elif currentPosition == endPositionY:
		tween = create_tween().set_trans(Tween.TRANS_SINE).set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
		tween.tween_callback($Area2D/Sprite2D.hide)
		playElevatorSound()
		tween.tween_interval(2)
		tween.tween_property(self, "position:y", startPositionY, 5)
		tween.tween_callback($Area2D/Sprite2D.show)
		currentPosition = startPositionY

func callElevator(body: Node2D) -> void:
	if body.name == "Player":
		moveElevator()

func playElevatorSound() -> void:
	soundButton.play()
	await get_tree().create_timer(2).timeout
	soundElevatorMoving.play()
	await get_tree().create_timer(5).timeout
	soundElevatorMoving.stop()
