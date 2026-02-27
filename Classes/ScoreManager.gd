extends Node


class_name ScoreManager


@onready var audio_stream_player2d: AudioStreamPlayer2D = $AudioStreamPlayer2D


var _score_player_one: int = 0
var _score_player_two: int = 0


func _ready() -> void:
	SignalHub.on_scored.connect(on_scored)


func get_player_one_score() -> int:
	return _score_player_one
	
	
func get_player_two_score() -> int:
	return _score_player_two


func on_scored(player: Constants.Player) -> void:
	if player == Constants.Player.PlayerOne:
		_score_player_one += 1
	elif player == Constants.Player.PlayerTwo:
		_score_player_two += 1
	audio_stream_player2d.play()
	
	print("Current score: P1: %d , P2: %d" % [_score_player_one, _score_player_two])
	


