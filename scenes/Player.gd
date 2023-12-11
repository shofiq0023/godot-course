extends CharacterBody2D

const maxHorizontalSpeed = 170.0;
const jumpVelocity = 390.0;
const horizontalAcceleration = 1500;
const jumpTerminationMulti = 3;

var gravity = 1000;
var hasDoubleJump;

func _physics_process(delta):
	var moveVector = get_movement_vector();
	
	velocity.x += moveVector.x * horizontalAcceleration * delta;
	if (moveVector.x == 0):
		velocity.x = lerp(0.0, velocity.x, pow(2, -30 * delta));
		
	velocity.x = clamp(velocity.x, -maxHorizontalSpeed, maxHorizontalSpeed);
	
	if (moveVector.y < 0 && (is_on_floor() || !$CoyoteTimer.is_stopped() || hasDoubleJump)):
		velocity.y = moveVector.y * jumpVelocity;
		if (!is_on_floor() && $CoyoteTimer.is_stopped()):
			hasDoubleJump = false;
		
		$CoyoteTimer.stop();
	
	if (velocity.y < 0 && !Input.is_action_pressed(("jump"))):
		velocity.y += gravity * jumpTerminationMulti * delta;
	else:
		velocity.y += gravity * delta;
	
	var wasOnFloor = is_on_floor();
	move_and_slide();
	
	if (wasOnFloor && !is_on_floor()):
		$CoyoteTimer.start();
	
	if (is_on_floor()):
		hasDoubleJump = true;
	
	update_animation();

func get_movement_vector():
	var moveVector = Vector2.ZERO;
	moveVector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left");
	moveVector.y = -1 if Input.is_action_just_pressed("jump") else 0;
	return moveVector;

func update_animation():
	var moveVector = get_movement_vector();
	
	if (!is_on_floor()):
		$AnimatedSprite2D.play("jump");
	elif (moveVector.x != 0):
		$AnimatedSprite2D.play("run");
	else:
		$AnimatedSprite2D.play("idle");
	
	if (moveVector.x != 0):
		$AnimatedSprite2D.flip_h = false if moveVector.x < 0 else true;


