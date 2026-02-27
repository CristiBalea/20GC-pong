extends Control


@export var score_manager: ScoreManager 

@onready var score_player1: Label = $MarginContainer/HBoxContainer2/ScorePlayer1
@onready var score_player2: Label = $MarginContainer/HBoxContainer2/ScorePlayer2
@onready var timer: Timer = $Timer
@onready var elapsed_time_label: Label = $MarginContainer/HBoxContainer/VBoxContainer/ElapsedTimeLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	score_player1.text = "%d" % score_manager.get_player_one_score()
	score_player2.text = "%d" % score_manager.get_player_two_score()
	elapsed_time_label.text = format_seconds(get_time_elapsed())


func get_time_elapsed() -> float:
	return timer.wait_time - timer.time_left
	

func format_seconds(seconds: float) -> String:
	var minutes: int = floor(seconds / 60)
	var remaining_seconds: float = seconds - (minutes * 60)
	return str(minutes) + ":" + ("%02d" % (floor(remaining_seconds)))


func _on_timer_timeout() -> void:
	get_tree().paused = true
