extends Node2D

@onready var input_name = $UI/PopUp/LineEdit

func _on_back_pressed() -> void:
	queue_free()

func _on_validate_pressed() -> void:
	var txt = input_name.text as String
	
	if txt.length() <= 0:
		return
	
	var split_texts = txt.split("\n")
	
	for line in split_texts:
		if line.length() <= 0:
			continue
		
		Data.ActionElement(line, Data.current_list_name, Data.Action.ADD)
	
	var parent = get_parent()
	
	if parent is ListEltScene:
		Data.SaveAndLoad()
		parent.UpdateDisplay()
		
	queue_free()
