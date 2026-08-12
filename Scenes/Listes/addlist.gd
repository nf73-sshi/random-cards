extends Node2D

@onready var input_name = $UI/PopUp/LineEdit

func _on_back_pressed() -> void:
	queue_free()

func _on_validate_pressed() -> void:
	var result = Data.ActionList(input_name.text, Data.Action.ADD)
	
	if not result:
		return
		
	var parent = get_parent()
	
	if parent is ListScene:
		Data.SaveAndLoad()
		parent.UpdateDisplay()
		
	queue_free()
