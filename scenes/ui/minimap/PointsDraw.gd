extends Control

const PLAYER_COLOR := Color(1.0, 0.0, 0.0)   # Red color for player
@export var tile_size: Vector2 = Vector2(3, 3)
@export var tilemap: TileMapLayer
@export var player: Node2D

@onready var coordsLabel := $"../../CoordsLabel"
func _ready():
	tilemap = get_node("../../../../../Map/TileMap")

func _process(_delta):
	queue_redraw()

func _draw():
	if is_instance_valid(player):
		var player_pos = player.global_position / Vector2(tilemap.tile_set.tile_size) * tile_size
		var player_rect = Rect2(player_pos, tile_size*4)
		draw_rect(player_rect, PLAYER_COLOR)
		coordsLabel.text = str(Vector2i(player_pos))
	else:
		player = get_node_or_null("../../../../../Players/"+str(multiplayer.get_unique_id()))
