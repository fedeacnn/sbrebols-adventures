extends Node2D

const DIALOGUE_PATH: String = "res://assets/dialogues/island_01/island01_intro.json"

@onready var _dialogue_box: CanvasLayer = $DialogueBox


func _ready() -> void:
	_dialogue_box.dialogue_finished.connect(_on_dialogue_finished)
	_dialogue_box.load_and_start(DIALOGUE_PATH)


func _on_dialogue_finished() -> void:
	# Stage 1 (Infinite Runner) — da implementare
	pass
