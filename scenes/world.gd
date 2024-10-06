extends Node2D

@onready var gui = $GUI

func _ready() -> void:
	GameState.world_tilemap = %TileMap
	GameState.player = %Player
	GameState.player.init()
