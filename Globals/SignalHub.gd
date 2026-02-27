extends Node

signal on_scored(player: int)
signal start_game

func emit_on_scored(player: int) -> void:
	on_scored.emit(player)


func emit_start_game() -> void:
	start_game.emit()