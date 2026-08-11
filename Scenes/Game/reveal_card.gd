extends Node2D

func SetName(text: String):
	$UI/Label.text = text
	
func _on_ok_pressed() -> void:
	queue_free()
