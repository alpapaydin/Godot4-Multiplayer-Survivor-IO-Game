extends Control

const WALKABLE_TILES := [Vector2i(0,0), Vector2i(1,0), Vector2i(2,0), Vector2i(3,0), Vector2i(16,0), Vector2i(17,0)]
const WALKABLE_COLOR := Color(0.0, 1.0, 0.0)  # Green color for walkable tiles
const DEFAULT_COLOR := Color(1.0, 1.0, 1.0, 0.2)   # White color for non-walkable tiles

@export var tilemap: TileMap
@export var player: Node2D
@export var minimap_size: Vector2 = Vector2(200, 200)
@export var tile_size: Vector2 = Vector2(3, 3)
var drawn = false

func _ready():
	tilemap = get_node("../../../../../Map/TileMap")
	custom_minimum_size = minimap_size

func _draw():
	if tilemap == null:
		return
	var used_rect = tilemap.get_used_rect()
	for x in range(used_rect.size.x):
		for y in range(used_rect.size.y):
			var cell = tilemap.get_cell_source_id(0, Vector2i(x, y))
			if cell != -1:
				var cell_atlas_coords = tilemap.get_cell_atlas_coords(0, Vector2i(x, y))
				var tile_color = WALKABLE_COLOR if cell_atlas_coords in WALKABLE_TILES else DEFAULT_COLOR
				var tile_rect = Rect2(Vector2(x, y) * tile_size, tile_size)
				draw_rect(tile_rect, tile_color)

func _process(_delta):
	if not drawn and tilemap != null and tilemap.get_used_rect().size != Vector2i(0,0):
		queue_redraw()
		drawn = true
