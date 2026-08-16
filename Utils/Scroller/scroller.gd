class_name Scroller
extends Node2D

var minPosY = -1280.0
const maxPosY = 0.0

var drag_init_pos = Vector2.ZERO

func _input(event: InputEvent) -> void:
	if event is InputEventScreenTouch:
		if event.is_pressed():
			drag_init_pos = event.position
			
	if event is InputEventScreenDrag:
		position.y = clampf(position.y + event.position.y - drag_init_pos.y, minPosY, maxPosY)
		drag_init_pos = event.position
		
