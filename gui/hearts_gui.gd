extends HBoxContainer

const HEART_ICON = preload("res://gui/heart_icon.tscn")

func _ready() -> void:
	GameState.player_changed.connect(_on_player_changed)

func _on_player_changed() -> void:
	GameState.player.max_health_changed.connect(_on_max_health_changed)
	GameState.player.damage_taken.connect(_on_damage_taken)


func _on_max_health_changed(new_max_health: int) -> void:
	var current_hearts := get_children().size()
	
	if new_max_health < current_hearts:
		print("setting size to ", new_max_health)
		# remove hearts if max_health is shrinking
		for i in range(current_hearts, new_max_health, -1):
			print("removing item ", i-1)
			get_children()[i-1].queue_free()
		print("size is now ", get_children().size())
	else: 
		print("adding ", new_max_health - current_hearts, " new hearts")
		# add hearts if max_health is expanding
		for _i in range(new_max_health - current_hearts):
			var heart_icon := HEART_ICON.instantiate()
			add_child(heart_icon)
		print("size is now ", get_children().size())
		
	
	
func _on_damage_taken(damage: float) -> void:
	var half_damages = damage / 0.5 # get the number of half-hearts to deduct
	for _i in range(floor(half_damages)):
		for heart: HeartIcon in get_children():
			match heart.heart_state:
				HeartIcon.HeartState.HALF:
					heart.heart_state = HeartIcon.HeartState.EMPTY
					break
				HeartIcon.HeartState.FULL:
					heart.heart_state = HeartIcon.HeartState.HALF
					break
				_: # Hearts that are already empty
					continue
				
			
	
	
