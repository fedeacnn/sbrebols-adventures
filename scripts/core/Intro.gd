extends Node2D

const PANELS_PATH: String = "res://assets/dialogues/intro/intro_panels.json"

@onready var _cutscene_player: CanvasLayer = $CutscenePlayer


func _ready() -> void:
	_cutscene_player.cutscene_finished.connect(_on_cutscene_finished)
	_cutscene_player.load_cutscene(PANELS_PATH)
	_cutscene_player.start()


func _on_cutscene_finished() -> void:
	SceneTransition.change_scene("res://scenes/islands/island_01_calebres/Island01_Intro.tscn")
