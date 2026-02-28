extends CharacterBody2D


const SPEED = 250.0
const JUMP_VELOCITY = -430.0
@onready var sprite_2d: AnimatedSprite2D = $Sprite2D


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if is_on_floor():
		if velocity.x != 0:
			sprite_2d.animation = "running"	
		else:
			sprite_2d.animation = "default"
	if not is_on_floor():
		velocity += get_gravity() * delta
		sprite_2d.animation = "jumping"
		print("not on ground")

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	var isLeft = velocity.x < 0
	sprite_2d.flip_h = isLeft
