class_name DialogueSystem
extends Node

signal dialogue_finished
signal line_shown(speaker: String, text: String)

var _lines: Array = []
var _current_index: int = 0


func load_dialogue(path: String) -> void:
	var file := FileAccess.open(path, FileAccess.READ)
	if file == null:
		push_error("DialogueSystem: file not found — %s" % path)
		return
	var result := JSON.parse_string(file.get_as_text())
	file.close()
	if result == null or not result.has("lines"):
		push_error("DialogueSystem: invalid dialogue JSON — %s" % path)
		return
	_lines = result["lines"]
	_current_index = 0


func advance() -> void:
	if _current_index >= _lines.size():
		emit_signal("dialogue_finished")
		return
	var entry: Dictionary = _lines[_current_index]
	emit_signal("line_shown", entry.get("speaker", ""), entry.get("text", ""))
	_current_index += 1


func is_finished() -> bool:
	return _current_index >= _lines.size()
