extends HBoxContainer
class_name MiniGameTracker


@export var max_history: int = 10

# This dictionary will map your game strings ("maze", "bullet") to their PNGs
@export var game_icons: Dictionary 

var tracker_part_prefab = preload("res://assets/prefabs/ui/trackers/TrackerPart.tscn")
@export var empty_texture: Texture2D
var _current_index: int = 0

func _ready() -> void:
	
	# The moment you re-enter the WheelScene, immediately draw the existing history
	_update_ui()

func add_minigame(game_name: String) -> void:
	Events.minigame_history.append(game_name)
	
	if Events.minigame_history.size() > max_history:
		Events.minigame_history.pop_front()
		
	_update_one_track(game_name)
	_current_index += 1
	
func _update_one_track(game) -> void:
	var instance: TrackerPart = get_child(_current_index)
	if _icon_exists(game): instance.texture = game_icons[game]
	instance.visibility_to_100()
	
func current_index() -> int:
	return Events.minigame_history.size() - 1
	
func fail() -> void:
	var tracker_part: TrackerPart = get_child(current_index())
	tracker_part.set_fail()

func success() -> void:
	var tracker_part: TrackerPart = get_child(current_index())
	tracker_part.set_success()

func _create_empty() -> void:
	var instance: TrackerPart = tracker_part_prefab.instantiate()
	instance.set_new(empty_texture)
	add_child(instance)

func _icon_exists(game) -> bool:
	return game_icons.has(game) and game_icons[game] != null
		

func _create_prefab(game) -> void:
	var instance: TrackerPart = tracker_part_prefab.instantiate()
	if _icon_exists(game): instance.texture = game_icons[game]
	add_child(instance)

func _update_ui() -> void:
	for child in get_children():
		child.queue_free()
	
	for game in Events.minigame_history:
		_create_prefab(game)
	
	for id in range(current_index(), max_history):
		_create_empty()

func reset() -> void:
	_current_index = 0
