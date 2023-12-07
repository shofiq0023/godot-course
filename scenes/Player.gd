extends CharacterBody2D


const maxHorizontalSpeed = 170.0;
const jumpVelocity = 390.0;
const horizontalAcceleration = 1500;
const jumpTerminationMulti = 3;

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var moveVector = Vector2.ZERO;

func _physics_process(delta):
	moveVector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left");
	moveVector.y = -1 if Input.is_action_just_pressed("jump") else 0;
	
	velocity.x += moveVector.x * horizontalAcceleration * delta;
	if (moveVector.x == 0):
		velocity.x = lerp(0.0, velocity.x, pow(2, -30 * delta));
		
	velocity.x = clamp(velocity.x, -maxHorizontalSpeed, maxHorizontalSpeed);
	
	if (moveVector.y < 0 && is_on_floor()):
		velocity.y = moveVector.y * jumpVelocity;
	
	if (velocity.y < 0 && !Input.is_action_pressed(("jump"))):
		velocity.y += gravity * jumpTerminationMulti * delta;
	else:
		velocity.y += gravity * delta;
	
	move_and_slide();
