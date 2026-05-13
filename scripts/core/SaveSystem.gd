extends Node

const SAVE_PATH: String = "user://save.json"


func save_game() -> void:
	var data := {
		"keys_collected": GameManager.keys_collected,
		"crew_members": GameManager.crew_members,
		"current_island": GameManager.current_island,
		"islands_completed": GameManager.islands_completed,
	}
	var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	file.store_string(JSON.stringify(data))
	file.close()


func load_game() -> void:
	if not FileAccess.file_exists(SAVE_PATH):
		return
	var file := FileAccess.open(SAVE_PATH, FileAccess.READ)
	var raw := file.get_as_text()
	file.close()

	var result := JSON.parse_string(raw)
	if result == null:
		return

	GameManager.keys_collected = result.get("keys_collected", [])
	GameManager.crew_members = result.get("crew_members", [])
	GameManager.current_island = result.get("current_island", 0)
	GameManager.islands_completed = result.get("islands_completed", [])


func delete_save() -> void:
	if FileAccess.file_exists(SAVE_PATH):
		DirAccess.remove_absolute(SAVE_PATH)
