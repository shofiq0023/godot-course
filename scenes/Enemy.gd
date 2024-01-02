extends CharacterBody2D

enum Direction { RIGHT, LEFT };

@export var start_direction: Direction;

var max_speed = 25;
var direction = Vector2.ZERO;
var gravity = 500;

@onready var animated_sprite = $AnimatedSprite2D;
@onready var goal_detector = $GoalDetector;

func _ready():
	direction = Vector2.LEFT if start_direction == Direction.LEFT else Vector2.RIGHT;
	goal_detector.connect("area_entered", on_goal_detector_entered, CONNECT_DEFERRED);

func _physics_process(delta):
	velocity.x = (direction * max_speed).x;
	
	if (!is_on_floor()):
		velocity.y += gravity * delta;
	
	move_and_slide();
	
	animated_sprite.flip_h = true if direction.x > 0 else false;


func on_goal_detector_entered(_area):
	direction.x *= -1;
