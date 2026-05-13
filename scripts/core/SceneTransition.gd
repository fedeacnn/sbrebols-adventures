extends CanvasLayer

signal transition_finished

const FADE_DURATION: float = 0.4

@onready var _overlay: ColorRect = $Overlay
@onready var _tween: Tween = null


func _ready() -> void:
	_overlay.color = Color(0, 0, 0, 0)
	_overlay.mouse_filter = Control.MOUSE_FILTER_IGNORE


func change_scene(path: String) -> void:
	await _fade_in()
	get_tree().change_scene_to_file(path)
	await _fade_out()
	emit_signal("transition_finished")


func _fade_in() -> void:
	_overlay.mouse_filter = Control.MOUSE_FILTER_STOP
	_tween = create_tween()
	_tween.tween_property(_overlay, "color:a", 1.0, FADE_DURATION)
	await _tween.finished


func _fade_out() -> void:
	_tween = create_tween()
	_tween.tween_property(_overlay, "color:a", 0.0, FADE_DURATION)
	await _tween.finished
	_overlay.mouse_filter = Control.MOUSE_FILTER_IGNORE
