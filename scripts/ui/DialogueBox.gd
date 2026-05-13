extends CanvasLayer

signal dialogue_finished

@onready var _speaker_label: Label = $Panel/VBox/SpeakerLabel
@onready var _text_label: Label = $Panel/VBox/TextLabel

var _dialogue_system: DialogueSystem


func _ready() -> void:
	_dialogue_system = DialogueSystem.new()
	add_child(_dialogue_system)
	_dialogue_system.line_shown.connect(_on_line_shown)
	_dialogue_system.dialogue_finished.connect(_on_dialogue_finished)


func load_and_start(path: String) -> void:
	_dialogue_system.load_dialogue(path)
	_dialogue_system.advance()
	show()


func _unhandled_input(event: InputEvent) -> void:
	if not visible:
		return
	if event is InputEventScreenTouch and event.pressed:
		_dialogue_system.advance()
	elif event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		_dialogue_system.advance()


func _on_line_shown(speaker: String, text: String) -> void:
	_speaker_label.text = speaker
	_text_label.text = text


func _on_dialogue_finished() -> void:
	hide()
	emit_signal("dialogue_finished")
