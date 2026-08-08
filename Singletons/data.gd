extends Node

enum Action {ADD, REMOVE}

class Element:
	var text : String = ""

class List:
	var elements : Dictionary[String, Element]

var listes : Dictionary[String, List]
var current_list_name : String = ""

func ActionList(id :String, type: Action) -> bool:
	match(type):
		Action.ADD:
			if listes.has(id):
				return false
			listes[id] = List.new()
			
		Action.REMOVE:
			if not listes.has(id):
				return false
				
			listes.erase(id)
	
	for list in listes.keys():
		var elements = listes[list].elements
		print("List : ", list)
		print("Elements : ", elements.keys())

	print("\n-----------------------------------------\n")
	
	return true
	
func ActionElement(text : String, list_id :String, type: Action) -> bool:
	match(type):
		Action.ADD:
			if not listes.has(list_id):
				return false
	
			if listes[list_id].elements.has(text):
				return false
	
			var element = Element.new()
			element.text = text
	
			listes[list_id].elements[text] = element
	
		Action.REMOVE:
			if not listes.has(list_id):
				return false
	
			if not listes[list_id].elements.has(text):
				return false
				
			listes[list_id].elements.erase(text)
		
	return true
		
func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	pass
