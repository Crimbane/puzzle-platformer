extends Button


func _ready() -> void:
	pressed.connect(exitGame)

func exitGame() -> void:
	get_tree().reload_current_scene()
