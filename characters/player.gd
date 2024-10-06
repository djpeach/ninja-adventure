class_name Player extends CharacterBody2D

signal max_health_changed(max_health: int)
signal damage_taken(damage: float)


@export var speed: int = 100

@onready var anim_player := $AnimationPlayer
@onready var effects_player := $EffectsAnimations
@onready var hurt_box := $HurtBox

var direction := Vector2.ZERO
var can_walk := true: set = set_can_walk
var is_hurt := false: set = set_is_hurt

func init() -> void:
	max_health_changed.emit(3)


func _physics_process(delta: float) -> void:
	handle_input()
	handle_animation()
	handle_collisions()

	move_and_slide()


func handle_input() -> void:
	if can_walk:
		direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * speed

func handle_animation() -> void:
	if not velocity or not can_walk:
		return anim_player.stop()
	
	var animation_map = {
		Vector2.UP: "walk_up",
		Vector2.DOWN: "walk_down",
		Vector2.LEFT: "walk_left",
		Vector2.RIGHT: "walk_right",
		(Vector2.UP + Vector2.RIGHT).normalized(): "walk_up",
		(Vector2.UP + Vector2.LEFT).normalized(): "walk_up",
		(Vector2.DOWN + Vector2.RIGHT).normalized(): "walk_down",
		(Vector2.DOWN + Vector2.LEFT).normalized(): "walk_down",
	}
	
	var direction: Vector2 = velocity.normalized()
	anim_player.play(animation_map[direction])


func handle_collisions():
	if is_hurt: return
	
	for hit_box in hurt_box.get_overlapping_areas():
		handle_hit_by_enemy(hit_box)
		break # only first hitbox will have an effect


func handle_hit_by_enemy(area: Area2D) -> void:
	if is_hurt: return
	
	is_hurt = true
	can_walk = false
	
	damage_taken.emit(.5)
	
	# will blink player and reset hurt and walk values
	effects_player.play("blink_hurt")
	
	# get vector from area hitbox to our hurtbox and push back character that way
	direction = area.global_position.direction_to(global_position)


func set_can_walk(v: bool) -> void:
	can_walk = v
	
func set_is_hurt(v: bool) -> void:
	is_hurt = v
