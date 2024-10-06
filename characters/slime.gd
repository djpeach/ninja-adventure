extends CharacterBody2D

@export var speed: int =  30
@export var destination_point: Marker2D

@onready var start_position := self.global_position
@onready var end_position := self.destination_point.global_position
@onready var anim_player := $AnimationPlayer

var allow_movement = false

func _physics_process(delta: float) -> void:
	process_movement()
	update_animation()
	
func process_movement() -> void:
	var move_vector = end_position - global_position
	if move_vector.length() < .5:
		change_direction()
		
	velocity = move_vector.normalized() * speed
	
	move_and_slide()


func change_direction() -> void:
	var old_end_position = end_position
	end_position = start_position
	start_position = old_end_position

func update_animation() -> void:
	match [velocity.x, velocity.y]:
		[_, var y] when y > 0:
			anim_player.play("walk_down")
		[_, var y] when y < 0:
			anim_player.play("walk_up")
		[var x, _] when x > 0:
			anim_player.play("walk_right")
		[var x, _] when x < 0:
			anim_player.play("walk_left")
		_:
			anim_player.stop()
	
