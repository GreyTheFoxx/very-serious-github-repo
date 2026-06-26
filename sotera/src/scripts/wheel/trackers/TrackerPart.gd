extends TextureRect

class_name TrackerPart

@export var fail: TextureRect
@export var success: TextureRect

func _ready() -> void:
	if success != null: # init()
		success.visible = false
		fail.visible = false

func set_new(texture: Texture2D) -> void:
	self.texture = texture
	modulate.a = 0.3 # 50%

func visibility_to_100() -> void:
	modulate.a = 1.0 # 100% opacity
	success.visible = true
	
func set_success() -> void:
	modulate.a = 1.0 # 100% opacity
	success.visible = true
	
func set_fail() -> void:
	modulate.a = 0.25 # 25% opacity
	fail.visible = true
