class_name CutscenePlayer
extends CanvasLayer

signal cutscene_finished

@onready var _panel_image: TextureRect = $PanelImage
@onready var _text_label: Label = $TextOverlay/VBox/TextLabel
@onready var _skip_button: Button = $SkipButton

var _panels: Array = []
var _current_index: int = 0


func load_cutscene(path: String) -> void:
	var file := FileAccess.open(path, FileAccess.READ)
	if file == null:
		push_error("CutscenePlayer: file not found — %s" % path)
		return
	var result: Variant = JSON.parse_string(file.get_as_text())
	file.close()
	if result == null or not result.has("panels"):
		push_error("CutscenePlayer: invalid JSON — %s" % path)
		return
	_panels = result["panels"]
	_current_index = 0


func start() -> void:
	_skip_button.pressed.connect(_on_skip_pressed)
	_show_panel(0)


func _show_panel(index: int) -> void:
	if index >= _panels.size():
		cutscene_finished.emit()
		return

	var panel: Dictionary = _panels[index]
	var image_path: String = panel.get("image", "")

	if image_path != "" and ResourceLoader.exists(image_path):
		_panel_image.texture = load(image_path)
	else:
		_panel_image.texture = null

	_text_label.text = panel.get("text", "")


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventScreenTouch and event.pressed:
		_advance()
	elif event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		_advance()


func _advance() -> void:
	_current_index += 1
	_show_panel(_current_index)


func _on_skip_pressed() -> void:
	cutscene_finished.emit()
