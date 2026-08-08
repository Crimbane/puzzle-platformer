extends Area2D

# using change to packed scene can corrupt file when you use export packed scene

@export var message: String
@export_file("*.tscn") var nextScenePath: String
var onLever = false
@onready var soundLeverPull: AudioStreamPlayer2D = $"Lever Pull"


func _ready() -> void:
	if "soundVolume" in VolumeSettings:
		soundLeverPull.volume_db = VolumeSettings.soundVolume
	$Label.text = message

func _on_lever_interacted() -> void:
	if onLever && $Timer.is_stopped():
		$Timer.start()
		$Lever.flip_h = true
		$Label.visible = false
		soundLeverPull.play()
		call_deferred("loadNextScene")

func loadNextScene() -> void:
	if nextScenePath != "": 
		var animation = LoadingScreen.get_node("AnimationPlayer")
		
		animation.play("transition")
		await animation.animation_finished
		
		get_tree().change_scene_to_file(nextScenePath)
		
		animation.play_backwards("transition")
	else:
		print("Warning: No next scene path assigned in the Inspector")


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		onLever = true
		if $Timer.is_stopped():
			$Label.visible = true


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		onLever = false
		$Label.visible = false


func _on_timer_timeout() -> void:
	$Lever.flip_h = false
	soundLeverPull.play()
	if onLever:
		$Label.visible = true
