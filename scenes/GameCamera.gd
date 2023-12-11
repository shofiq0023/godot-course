extends Camera2D

var targetPosition = Vector2.ZERO;

@export var backgroundColor = Color();

func _ready():
	RenderingServer.set_default_clear_color(backgroundColor);

func _process(delta):
	acquireTargetPosition();
	
	global_position = lerp(targetPosition, global_position, pow(2, -15 * delta));
	
func acquireTargetPosition():
	var players = get_tree().get_nodes_in_group("playerGroup");
	if (players.size() > 0):
		var player = players[0];
		targetPosition = player.global_position;
