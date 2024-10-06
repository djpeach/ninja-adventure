class_name HeartIcon extends Panel



enum HeartState {FULL=4, HALF=2, EMPTY=0}
@export var heart_state: HeartState = HeartState.FULL:
	set (new_value):
		heart_state = new_value
		if sprite:
			sprite.frame = new_value


@onready var sprite: Sprite2D = $Sprite2D


func _ready() -> void:
	sprite.frame = heart_state
