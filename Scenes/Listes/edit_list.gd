class_name EditList
extends Node2D

var current_list : String = ""

func InitList():
	$UI/PopUp/LineEdit.text = current_list
	
func _on_back_on_trigger() -> void:
	queue_free()

func _on_validate_on_trigger() -> void:
	var new_name = $UI/PopUp/LineEdit.text
	
	if Data.listes.has(new_name):
		if current_list != new_name:
			print("key already exists !")
			return

	Data.EditList(current_list, new_name)
	var parent = get_parent() as ListScene
	parent.UpdateDisplay()
	
	queue_free()
