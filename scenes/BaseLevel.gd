extends Node2D

var player_scene = preload("res://scenes/Player.tscn");
var spawn_position = Vector2.ZERO;
var current_player_node = null;

func _ready():
	spawn_position = $Player.global_position;
	register_player($Player);

func register_player(player):
	current_player_node = player;
	current_player_node.connect("died", on_player_died, CONNECT_DEFERRED);

func create_player():
	var player_instance = player_scene.instantiate();
	add_sibling(player_instance);
	player_instance.global_position = spawn_position;
	register_player(player_instance);


func on_player_died():
	current_player_node.queue_free();
	create_player();
