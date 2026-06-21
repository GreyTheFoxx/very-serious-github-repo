extends Node2D

@onready var cheering_charater_spawner: Node2D = $CheeringCharaterSpawner

@export var space_between_seats_x: int
@export var space_between_seats_y: int
@export var texture_whidth: int = 50
@export var texture_height: int = 50

#seat poseation and is seat taken
var seats: Dictionary[Vector2, bool]
var seat_size: Vector2
var num_of_seats_per_row: int


 
func _ready() -> void:
	on_start()
	cheering_charater_spawner.seats = seats
	cheering_charater_spawner.max_characters = seats.size() + 5

func on_start() -> void:
	num_of_seats_per_row = int(1920 / (space_between_seats_x + texture_whidth)) + 2
	var seat_poseation: Vector2 =  Vector2(0 - space_between_seats_x - texture_whidth, 100)
	for i in range(3):
		for seat in range(num_of_seats_per_row):
			seats[seat_poseation] = false
			seat_poseation.x += texture_whidth + space_between_seats_x
		seat_poseation.y += space_between_seats_y + texture_height
		seat_poseation.x = 0 -space_between_seats_x - texture_whidth
