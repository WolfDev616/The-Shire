extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -450.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var anim = $AnimatedSprite2D
@onready var player_footsteps: AudioStreamPlayer2D = $PlayerFootsteps

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

	#if Input.is_action_just_pressed("jump") and is_on_floor():
		#velocity.y = JUMP_VELOCITY

	var direction = 0.0
	if Input.is_key_pressed(KEY_D): direction += 1
	if Input.is_key_pressed(KEY_A): direction -= 1
	velocity.x = direction * SPEED
	#print("Direction: ", direction, " | Velocity X: ", velocity.x)

	if direction != 0:
		anim.flip_h = direction < 0
		anim.play("walk")
	else:
		anim.play("idle")

	move_and_slide()

	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)



func _on_animated_sprite_2d_frame_changed() -> void:
	if anim.animation == "walk":
		if not player_footsteps.playing:
			player_footsteps.play()
