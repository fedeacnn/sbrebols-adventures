class_name IslandBase
extends Node2D

var island_id: int
var boss_defeated: bool = false


func start_island() -> void:
	pass


func complete_island(crew_member_name: String = "") -> void:
	GameManager.complete_island(island_id, crew_member_name)
	SceneTransition.change_scene("res://scenes/world/Overworld.tscn")
