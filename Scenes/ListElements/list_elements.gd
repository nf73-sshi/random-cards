extends Node2D 

var add_elt = preload("res://Scenes/ListElements/add_element.tscn")

func _ready() -> void:
	$UI/Label.text = "List : " + Data.current_list_name

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Listes/listes.tscn")

func _on_add_elt_pressed() -> void:
	if get_children().size() >= 2:
		return
	
	add_child(add_elt.instantiate())
