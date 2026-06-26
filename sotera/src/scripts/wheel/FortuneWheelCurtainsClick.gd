extends Area2D

@export var curtains: CurtainSystem

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion: return # ignore mouse motion
	print("HHJ")
	if event.pressed: return # touch up is required
	
	# Mouse click
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		_curtain_body_clicked()
		
	# Mobile touch
	elif event is InputEventScreenTouch: _curtain_body_clicked()

func _curtain_body_clicked() -> void:
	if curtains.closed(): curtains.open_full()
	elif curtains.opened(): curtains.close_full()
