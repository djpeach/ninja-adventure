extends Node

signal world_tilemap_changed
signal player_changed

var world_tilemap: TileMap:
	set(value):
		world_tilemap = value
		world_tilemap_changed.emit()

var player: Player: 
	set(value): 
		player = value
		player_changed.emit()
