class_name MinigameBase
extends Node2D

signal minigame_completed(success: bool)
signal minigame_score_updated(score: int)

var _is_running: bool = false


func start_minigame() -> void:
	_is_running = true


func end_minigame(success: bool) -> void:
	_is_running = false
	emit_signal("minigame_completed", success)


func _update_score(score: int) -> void:
	emit_signal("minigame_score_updated", score)
