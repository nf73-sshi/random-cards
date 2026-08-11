extends Node2D

var drag_init_pos = Vector2.ZERO
const px_drag = 4.0

func _input(event: InputEvent) -> void:
	if event is InputEventScreenTouch:
		if event.is_pressed():
			drag_init_pos = event.position
			
	if event is InputEventScreenDrag:
		position.y += event.position.y - drag_init_pos.y
		drag_init_pos = event.position
		
