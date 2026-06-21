extends Node2D

@onready var timer: Timer = $Timer

@export var cheering_character_scene: PackedScene
@export var min_wait_time: int = 5
@export var max_wait_time: int = 10
@export var min_starters_cheering: int = 4
@export var max_starters_cheering: int = 10

var seats: Dictionary[Vector2, bool]
var max_characters: int
var current_character_count: int = 0

func _ready() -> void:
	timer.timeout.connect(on_character_should_spawen)
	max_characters = seats.size() + 5
	await get_tree().physics_frame
	for i in range(randi_range(min_starters_cheering, max_starters_cheering)):
		on_character_should_spawen()

func on_character_should_spawen() -> void:
	print(current_character_count)
	if current_character_count >= max_characters:
		return
	var free_seats: Array[Vector2] = seats.keys()
	var free_seat: Vector2
	
	while(free_seats.size() > 0):
		free_seat = free_seats[randi_range(0, free_seats.size() - 1)]
		if not seats[free_seat]:
			seats[free_seat] = true
			spawn_cheering_character(free_seat)
			print("spawning caracter on seat")
			return

		free_seats.erase(free_seat)

	spawn_cheering_character(Vector2(randi_range(0, 1800), randi_range(0, 600)))
	free_seats.erase(free_seat)

func spawn_cheering_character(spawn_position) -> void:
	var cheering_charcater: Node2D = cheering_character_scene.instantiate()
	cheering_charcater.global_position = spawn_position
	cheering_charcater.cheering_character_spawner = self
	add_child(cheering_charcater)
	current_character_count += 1
	timer.wait_time = randi_range(min_wait_time, max_wait_time)

func change_seat_state(seat: Vector2, is_block: bool):
	if seat.
