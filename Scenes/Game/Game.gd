extends Node2D


const BALL: PackedScene = preload("res://Scenes/Ball/Ball.tscn")


var _ball: Ball 


func _ready() -> void:
	SignalHub.on_scored.connect(on_scored)
	SignalHub.start_game.connect(on_start_game)
	get_tree().paused = true
	

func on_scored(_player: int) -> void:
	_ball = BALL.instantiate()
	_ball.global_position = Vector2(get_viewport_rect().size.x / 2, get_viewport_rect().size.y / 2)
	_ball.launch_ball()
	call_deferred("add_child", _ball)


func on_start_game() -> void:
	on_scored(1)
