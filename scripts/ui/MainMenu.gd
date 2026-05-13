extends Node2D

@onready var _play_button: Button = $UI/ButtonContainer/PlayButton
@onready var _settings_button: Button = $UI/ButtonContainer/SettingsButton
@onready var _settings_panel: Panel = $UI/SettingsPanel
@onready var _music_slider: HSlider = $UI/SettingsPanel/VBox/MusicSlider
@onready var _sfx_slider: HSlider = $UI/SettingsPanel/VBox/SFXSlider
@onready var _close_button: Button = $UI/SettingsPanel/VBox/CloseButton


func _ready() -> void:
	_play_button.pressed.connect(_on_play_pressed)
	_settings_button.pressed.connect(_on_settings_pressed)
	_close_button.pressed.connect(_on_close_settings_pressed)
	_music_slider.value_changed.connect(AudioManager.set_music_volume)
	_sfx_slider.value_changed.connect(AudioManager.set_sfx_volume)

	if SaveSystem.has_save():
		_play_button.text = "Continua"

	_settings_panel.hide()


func _on_play_pressed() -> void:
	if SaveSystem.has_save():
		SceneTransition.change_scene("res://scenes/islands/island_01_calebres/Island01_Intro.tscn")
	else:
		SceneTransition.change_scene("res://scenes/core/Intro.tscn")


func _on_settings_pressed() -> void:
	_settings_panel.visible = not _settings_panel.visible


func _on_close_settings_pressed() -> void:
	_settings_panel.hide()
