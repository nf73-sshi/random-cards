class_name EditElt
extends Node2D

var current_element = ""

func InitElement():
	$UI/PopUp/LineEdit.text = current_element
	$UI/PopUp/CountEdit.text = str(Data.listes[Data.current_list_name].elements[current_element].count)

func _on_back_pressed() -> void:
	queue_free()

func _on_validate_pressed() -> void:
	var new_name = $UI/PopUp/LineEdit.text as String
	
	if new_name.length() <= 0:
		return
		
	if Data.listes[Data.current_list_name].elements.has(new_name):
		if current_element != new_name:
			print("key already exists !")
			return
	
	var count = $UI/PopUp/CountEdit.text.to_int()
	if count <= 0:
		count = 1

	Data.EditElement(current_element, new_name, count)
	var parent = get_parent() as ListEltScene
	parent.UpdateDisplay()
	
	queue_free()
