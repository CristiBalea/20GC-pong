extends Control


class_name StartGameUi


@onready var start_game: Label = $MarginContainer/PressSpaceToStartLabel
@onready var countdown_timer: Timer = $CountdownTimer
@onready var countdown_label: Label = $MarginContainer/CountdownLabel
@onready var countdown_audio: AudioStreamPlayer2D = $CountdownAudio


var sounds: Dictionary[Variant, Variant] = {
	"one" = load("res://Assets/sounds/1.ogg"),
	"two" = load("res://Assets/sounds/2.ogg"),
	"three" = load("res://Assets/sounds/3.ogg"),
	"game_over" = load("res://Assets/sounds/game_over.ogg"),
	"tie" = load("res://Assets/sounds/it's_a_tie.ogg"),
	"paddle_impact" = load("res://Assets/sounds/paddle_impact.ogg")
	
}


func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("action"):
		start_game.hide()
		countdown_timer.start()
		countdown_label.show()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	countdown_label.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	show_countdown()


func show_countdown() -> void:
	var time_left = ceil(countdown_timer.time_left)
	if time_left == 3:
		countdown_audio.play()
	print(time_left)


func _on_countdown_timer_timeout() -> void:
	countdown_label.hide()
	get_tree().paused = false
	SignalHub.emit_start_game()
