extends Node

@export var curtains: CurtainSystem

func _ready() -> void:
	curtains.open_full()

func on_level_select() -> void:
	pass
