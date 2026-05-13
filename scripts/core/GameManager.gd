extends Node

const MAX_ISLANDS: int = 10

var keys_collected: Array = []
var crew_members: Array = []
var current_island: int = 0
var islands_completed: Array = []


func complete_island(island_id: int, crew_member_name: String) -> void:
	if island_id not in islands_completed:
		islands_completed.append(island_id)
		keys_collected.append(island_id)
	if crew_member_name != "" and crew_member_name not in crew_members:
		crew_members.append(crew_member_name)


func is_island_completed(island_id: int) -> bool:
	return island_id in islands_completed


func get_keys_count() -> int:
	return keys_collected.size()
