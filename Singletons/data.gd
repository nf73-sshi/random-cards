extends Node

const save_path = "user://save.json"

enum Action {ADD, REMOVE}

class Element:
	var text : String = ""
	var count : int = 1
	
	func to_dict() -> Dictionary:
		return {"text": text,
				"count": count}

	static func from_dict(data: Dictionary) -> Element:
		var e = Element.new()
		e.text = data.get("text", "")
		e.count = data.get("count", 1)
		
		return e
	
class List:
	var elements : Dictionary[String, Element]
	
	func to_dict() -> Dictionary:
		var dict = {}
		for key in elements:
			dict[key] = elements[key].to_dict() # On appelle récursivement to_dict()
		return dict

	static func from_dict(data: Dictionary) -> List:
		var l = List.new()
		for key in data:
			l.elements[key] = Element.from_dict(data[key])
		return l
		
var listes : Dictionary[String, List]
var current_list_name : String = "Brawlers"

func _print_content():
	for list in listes.keys():
		var elements = listes[list].elements
		print("List : ", list)
		print("Elements : ", elements.keys())

	print("\n-----------------------------------------\n")	

func SaveAndLoad():
	SaveConfig()
	LoadConfig()

func SaveConfig():
	var data_to_save = {}

	for list_name in listes:
		data_to_save[list_name] = listes[list_name].to_dict()
		
	var json_string = JSON.stringify(data_to_save, "\t", true)
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	
	if file:
		file.store_string(json_string)
		file.close()
		print("saved !")
	else:
		print("file not opened !")
	
func LoadConfig():
	if not FileAccess.file_exists(save_path):
		print("no save found !")
		return
		
	var file = FileAccess.open(save_path, FileAccess.READ)
	var json_text = file.get_as_text()
	file.close()
	
	var json = JSON.new()
	var error = json.parse(json_text)

	if error == OK:
		var raw_data = json.data
		listes.clear()
		
		for list_name in raw_data:
			listes[list_name] = List.from_dict(raw_data[list_name])
		
		print("loaded !")
	else:
		print("Bug parsing : ", json.get_error_message())

func EditList(current_list: String, new_name: String):
	if current_list == new_name:
		return
	else:
		var data = listes[current_list]
		listes[new_name] = data
		
		listes.erase(current_list)
	
	SaveAndLoad()

func EditElement(current_element: String, new_name: String, new_count: int):
	if current_element == new_name:
		listes[current_list_name].elements[current_element].count = new_count
	else:
		var data = listes[current_list_name].elements[current_element]
		listes[current_list_name].elements[new_name] = data
		
		listes[current_list_name].elements.erase(current_element)
	
	SaveAndLoad()

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
	
	SaveAndLoad()
	_print_content()
	return true
	
func ActionElement(text : String, list_id :String, type: Action, count: int = 1) -> bool:
	match(type):
		Action.ADD:
			if not listes.has(list_id):
				return false
	
			if listes[list_id].elements.has(text):
				return false
	
			var element = Element.new()
			element.text = text
			element.count = count
			
			listes[list_id].elements[text] = element
	
		Action.REMOVE:
			if not listes.has(list_id):
				return false
	
			if not listes[list_id].elements.has(text):
				return false
				
			listes[list_id].elements.erase(text)
	
	SaveAndLoad()
	_print_content()	
	return true
		
func _ready() -> void:
	LoadConfig()
	
func _process(delta: float) -> void:
	pass
