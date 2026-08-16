class_name ListScene
extends Node2D

var edit_list = preload("res://Scenes/Listes/edit_list.tscn")
var current_display : Array[Node]

func EditCurrentList(list_name: String):
	if get_children().size() >= 2:
		return
		
	var scene = edit_list.instantiate() as EditList
	add_child(scene)
	scene.current_list = list_name
	scene.InitList()

func ChangeToGameScene(list_name: String):
	Data.current_list_name = list_name
	get_tree().change_scene_to_file("res://Scenes/Game/game.tscn")

func ChangeToElementsScene(list_name: String):
	Data.current_list_name = list_name
	get_tree().change_scene_to_file("res://Scenes/ListElements/list_elements.tscn")

func RefreshAndDoAction(list_name: String, type :Data.Action):
	Data.ActionList(list_name, type)
	UpdateDisplay()
	
func UpdateDisplay(text: String = ""):
	for e in current_display:
		e.queue_free()		
	current_display.clear()
	
	var offsetX = 20
	var offsetY = 100
	const size = Vector2(50, 50)
	const paddingX = 15.0
	
	for list_name in Data.listes.keys():
		if text != "" and not list_name.contains(text):
			continue
			
		#LABEL ADD
		var label = Label.new()
		$UI/Scroller.add_child(label)
		
		label.label_settings = LabelSettings.new()
		label.label_settings.font_size = 36
		
		label.size = Vector2(600, 58)
		label.clip_text = true
		
		label.text = list_name
		label.position = Vector2(offsetX, offsetY)

		
		current_display.append(label)
		
		var create_remove_button = func(offsetX, offsetY):
			var remove = Click2Button.new()
			$UI/Scroller.add_child(remove)
		
			remove.text = "X"
			remove.size = size
			remove.position = Vector2(get_viewport_rect().size.x - (size.x + paddingX), offsetY)
			current_display.append(remove)
		
			remove.on_trigger.connect(RefreshAndDoAction.bind(list_name, Data.Action.REMOVE))
		var create_edit_button = func(offsetX, offsetY):
			var edit = Button.new()
			$UI/Scroller.add_child(edit)
			
			edit.text = "Edit"
			edit.size = size
			edit.position = Vector2(get_viewport_rect().size.x - (size.x + paddingX) * 2.0, offsetY)
			current_display.append(edit)
			
			edit.pressed.connect(ChangeToElementsScene.bind(list_name))
		var create_rename_button = func(offsetX, offsetY):
			var use = Button.new()
			$UI/Scroller.add_child(use)
			
			use.text = "Nom"
			use.size = size
			use.position = Vector2(get_viewport_rect().size.x - (size.x + paddingX) * 3.0, offsetY)
			current_display.append(use)
			
			use.pressed.connect(EditCurrentList.bind(list_name))
		var create_use_button = func(offsetX, offsetY):
			var use = Button.new()
			$UI/Scroller.add_child(use)
			
			use.text = "Jouer"
			use.size = size
			use.position = Vector2(get_viewport_rect().size.x - (size.x + paddingX) * 4.0, offsetY)
			current_display.append(use)
			
			use.pressed.connect(ChangeToGameScene.bind(list_name))
			
		create_remove_button.call(offsetX, offsetY)
		create_edit_button.call(offsetX, offsetY)
		create_rename_button.call(offsetX, offsetY)
		create_use_button.call(offsetX, offsetY)
		
		offsetY += 100
	$UI/Scroller.minPosY = -offsetY + 100.0
var addlist = preload("res://Scenes/Listes/addlist.tscn")

func _ready() -> void:
	UpdateDisplay()
	
func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Menu/menu.tscn")

func _on_add_list_pressed() -> void:
	if get_children().size() >= 2:
		return
	
	add_child(addlist.instantiate())

func _on_find_text_changed(new_text: String) -> void:
	UpdateDisplay(new_text)
	$UI/Scroller.position.y = 0.0
