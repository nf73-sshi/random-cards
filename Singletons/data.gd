extends Node

enum Action {ADD, REMOVE}

class Element:
	var text : String = ""

class List:
	var elements : Dictionary[String, Element]

var listes : Dictionary[String, List]
var current_list_name : String = "Brawlers"

func _print_content():
	for list in listes.keys():
		var elements = listes[list].elements
		print("List : ", list)
		print("Elements : ", elements.keys())

	print("\n-----------------------------------------\n")	

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
	
	_print_content()
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
	
	_print_content()	
	return true
		
func _ready() -> void:
	ActionList("Brawlers", Action.ADD)
	
	var brawlers = []
	
	for i in range(50):
		brawlers.append(str(i))
	
	for b in brawlers:
		ActionElement(b, "Brawlers", Action.ADD)
	
func _process(delta: float) -> void:
	pass
