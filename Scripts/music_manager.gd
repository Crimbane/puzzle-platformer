extends Node

@onready var musicPlayer: AudioStreamPlayer = $"Music Player"

@export var menuMusic: AudioStream
@export var gameMusic: AudioStream
@export var gameMusic2: AudioStream
@export var creditsMusic: AudioStream

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	musicPlayer.finished.connect(onGameMusicFinished)
	playMenuMusic()


func playMenuMusic():
	if musicPlayer.stream == menuMusic:
		return
	
	musicPlayer.stream = menuMusic
	musicPlayer.play()

func playGameMusic():
	if musicPlayer.stream == gameMusic or musicPlayer.stream == gameMusic2:
		return
	
	musicPlayer.stream = gameMusic
	musicPlayer.play()

func playCreditsMusic():
	if musicPlayer.stream == creditsMusic:
		return
	
	musicPlayer.stream = creditsMusic
	musicPlayer.play()

func onGameMusicFinished() -> void:
	if musicPlayer.stream == gameMusic:
		musicPlayer.stream = gameMusic2
		musicPlayer.play()
		print("track 1")
	elif musicPlayer.stream == gameMusic2:
		musicPlayer.stream = gameMusic
		musicPlayer.play()
		print("track 2")
