extends Node

@onready var music: AudioStreamPlayer = $Player/Music
@onready var buttonSound1: AudioStreamPlayer2D = $"Button/Button Down"
@onready var buttonSound2: AudioStreamPlayer2D = $"Button/Button Up"
@export var soundVolumeBox: RigidBody2D
@export var musicVolumeBox: RigidBody2D
@export var soundVolumeLabel: Label
@export var musicVolumeLabel: Label
var soundVolumeRemap: float
var musicVolumeRemap: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if VolumeSettings:
		soundVolumeBox.position = Vector2(clamp(remap(db_to_linear(VolumeSettings.soundVolume), 0, 1, 511.7, 736.3), 511.7, 736.3), 832)
		musicVolumeBox.position = Vector2(clamp(remap(db_to_linear(VolumeSettings.musicVolume), 0, .25, 1183.7, 1408.3), 1183.7, 1408.3), 832)
		soundVolumeLabel.text = "Sound Volume: " + str(int(snapped(db_to_linear(VolumeSettings.soundVolume), .01) * 100))
		musicVolumeLabel.text = "Music Volume: " + str(int(snapped(db_to_linear(VolumeSettings.musicVolume), .01) * 100 * 4))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	soundVolumeRemap = clamp(remap(soundVolumeBox.position.x, 511.7, 736.3, 0, 1), 0, 1)
	musicVolumeRemap = clamp(remap(musicVolumeBox.position.x, 1183.7, 1408.3, 0, .25), 0, .25)
	if VolumeSettings:
		VolumeSettings.soundVolume = linear_to_db(soundVolumeRemap)
		VolumeSettings.musicVolume = linear_to_db(musicVolumeRemap)
		soundVolumeLabel.text = "Sound Volume: " + str(int(snapped(db_to_linear(VolumeSettings.soundVolume), .01) * 100))
		musicVolumeLabel.text = "Music Volume: " + str(int(snapped(db_to_linear(VolumeSettings.musicVolume), .01) * 100 * 4))
		
		if music && buttonSound1 && buttonSound2:
			buttonSound1.volume_db = VolumeSettings.soundVolume
			buttonSound2.volume_db = VolumeSettings.soundVolume
			music.volume_db = VolumeSettings.musicVolume
