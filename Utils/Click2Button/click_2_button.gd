class_name Click2Button
extends Button

var timer : Timer = null

signal on_trigger
var confirm = false

func _on_pressed() -> void:
	if not confirm:
		confirm = true
		timer.start()
	else:
		confirm = false
		on_trigger.emit()

func _on_cooldown_timeout() -> void:
	confirm = false

func _ready() -> void:
	pressed.connect(_on_pressed)
	
	timer = Timer.new()
	add_child(timer)
	
	timer.autostart = false
	timer.wait_time = 0.5
	timer.one_shot = true
	timer.ignore_time_scale = true
	timer.timeout.connect(_on_cooldown_timeout)
	
