extends Area2D

# using change to packed scene can corrupt file when you use export packed scene

@export_file("*.tscn") var nextScenePath: String

func _ready() -> void:
	body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
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
