extends Camera2D


func _ready() -> void:
	connect_signals()
	
func connect_signals() ->void:
	GameState.connect("world_tilemap_changed", set_limits)
	
func set_limits() -> void:
	var world_size := GameState.world_tilemap.get_used_rect().size
	var cell_size := GameState.world_tilemap.tile_set.tile_size
	limit_top = 0
	limit_left = 0
	limit_right = world_size.x * cell_size.x
	limit_bottom = world_size.y * cell_size.y
