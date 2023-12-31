extends Node2D

@onready var area2d = $Area2D;
@onready var areaCollision = $Area2D/CollisionShape2D;
@onready var anim = $AnimationPlayer;

func _ready():
	area2d.connect("area_entered", on_area_entered);

func on_area_entered(area):
	anim.play("Pickup");
	call_deferred("disablePickup");

func disablePickup():
	areaCollision.disabled = true;
