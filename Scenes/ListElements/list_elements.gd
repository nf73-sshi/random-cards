class_name ListEltScene
extends Node2D 

var current_display : Array[Node]
var add_elt = preload("res://Scenes/ListElements/add_element.tscn")
var edit_elt = preload("res://Scenes/ListElements/edit_element.tscn")

func EditElement(element_name: String):
	if get_children().size() >= 2:
		return
		
	var scene = edit_elt.instantiate() as EditElt
	add_child(scene)
	scene.current_element = element_name
	scene.InitElement()

func RefreshAndDoAction(text :String, list_name: String, type :Data.Action):
	Data.ActionElement(text, list_name, type)
	UpdateDisplay()
	
func UpdateDisplay():
	for e in current_display:
		e.queue_free()		
	current_display.clear()
	
	var offsetX = 20
	var offsetY = 100
	const size = Vector2(60, 60)
	const paddingX = 10.0
	
	for elt_name in Data.listes[Data.current_list_name].elements.keys():
		
		#LABEL ADD
		var label = Label.new()
		$UI/Scroller.add_child(label)
		
		label.label_settings = LabelSettings.new()
		label.label_settings.font_size = 32
		
		label.size = Vector2(600, 58)
		label.clip_text = true
		
		label.text = elt_name
		label.position = Vector2(offsetX, offsetY)
	
		current_display.append(label)
		var create_remove_button = func(offsetX, offsetY):
			var remove = Click2Button.new()
			$UI/Scroller.add_child(remove)
		
			remove.text = "X"
			remove.size = size
			remove.position = Vector2(get_viewport_rect().size.x - (size.x + paddingX), offsetY)
			current_display.append(remove)
		
			remove.on_trigger.connect(RefreshAndDoAction.bind(elt_name, Data.current_list_name, Data.Action.REMOVE))
		var create_edit_button = func(offsetX, offsetY):
			var edit = Click2Button.new()
			$UI/Scroller.add_child(edit)
			
			edit.text = "Edit"
			edit.size = size
			edit.position = Vector2(get_viewport_rect().size.x - (size.x + paddingX) * 2.0, offsetY)
			current_display.append(edit)
			
			edit.on_trigger.connect(EditElement.bind(elt_name))
		var create_count_label = func(offsetX, offsetY):
			var c = Label.new()
			$UI/Scroller.add_child(c)
			c.label_settings = LabelSettings.new()
			c.label_settings.font_size = 40	
			c.size = Vector2(100, 100)
			c.clip_text = true
			c.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
			c.text = "X" + str(Data.listes[Data.current_list_name].elements[elt_name].count)
			c.position = Vector2(get_viewport_rect().size.x - (size.x + paddingX) * 4.0, offsetY)
			current_display.append(c)
			
		create_remove_button.call(offsetX, offsetY)
		create_edit_button.call(offsetX, offsetY)
		create_count_label.call(offsetX, offsetY)
		
		offsetY += 80
	$UI/Scroller.minPosY = -offsetY + 100.0
	
func _ready() -> void:
	$UI/Label.text = "LIST: " + Data.current_list_name
	UpdateDisplay()

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Listes/listes.tscn")

func _on_add_elt_pressed() -> void:
	if get_children().size() >= 2:
		return
	
	add_child(add_elt.instantiate())
