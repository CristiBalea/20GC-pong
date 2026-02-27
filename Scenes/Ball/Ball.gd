extends CharacterBody2D


class_name Ball


@export var initial_speed: float = 400.0
@export var speed_multiplier: float = 1.01 # Increases speed each hit


@onready var audio_stream_player2d: AudioStreamPlayer2D = $PaddleSound
@onready var wall_sound: AudioStreamPlayer2D = $WallSound


var direction: Vector2 = Vector2.ZERO


func _ready():
	SignalHub.on_scored.connect(on_scored)
	

func _physics_process(delta):
	# move_and_collide returns a KinematicCollision2D object upon impact
	var collision: KinematicCollision2D = move_and_collide(velocity * delta)
	
	if collision:
		# 1. Reflect the velocity based on the surface normal
		# The 'normal' is a vector pointing straight out of the surface hit
		velocity = velocity.bounce(collision.get_normal())
		
		# 2. Add a little juice: increase speed slightly on every hit
		velocity *= speed_multiplier
		
		# 3. Optional: Add logic for hitting paddles vs walls
		if collision.get_collider().is_in_group("paddles"):
			handle_paddle_hit(collision)
		else:
			wall_sound.play()
	
func handle_paddle_hit(collision):
	audio_stream_player2d.play()

func launch_ball() -> void:
	direction.x = [1, -1].pick_random()
	direction.y = [-0.8, 0.8].pick_random()
	velocity = direction.normalized() * initial_speed
	

func on_scored(player: int) -> void:
	queue_free()
