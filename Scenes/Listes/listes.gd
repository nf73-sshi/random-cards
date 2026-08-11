class_name ListScene
extends Node2D

var current_display : Array[Node]

func ChangeToGameScene(list_name: String):
	Data.current_list_name = list_name
	get_tree().change_scene_to_file("res://Scenes/Game/game.tscn")

func ChangeToElementsScene(list_name: String):
	Data.current_list_name = list_name
	get_tree().change_scene_to_file("res://Scenes/ListElements/list_elements.tscn")

func RefreshAndDoAction(list_name: String, type :Data.Action):
	Data.ActionList(list_name, type)
	UpdateDisplay()
	
func UpdateDisplay():
	for e in current_display:
		e.queue_free()		
	current_display.clear()
	
	var offsetX = 20
	var offsetY = 100
	
	for list_name in Data.listes.keys():
		
		#LABEL ADD
		var label = Label.new()
		$UI/Scroller.add_child(label)
		
		label.label_settings = LabelSettings.new()
		label.label_settings.font_size = 32
		
		label.text = list_name
		label.position = Vector2(offsetX, offsetY)
		label.size = Vector2(200, 100)
		offsetY += 40
		
		current_display.append(label)
		
		var create_remove_button = func(offsetX, offsetY):
			var remove = Button.new()
			$UI/Scroller.add_child(remove)
		
			remove.text = "X"
			remove.size = Vector2(30, 20)
			remove.position = Vector2(get_viewport_rect().size.x - 64.0, offsetY - 10.0)
			current_display.append(remove)
		
			remove.pressed.connect(RefreshAndDoAction.bind(list_name, Data.Action.REMOVE))
		var create_edit_button = func(offsetX, offsetY):
			var edit = Button.new()
			$UI/Scroller.add_child(edit)
			
			edit.text = "Edit"
			edit.size = Vector2(30, 20)
			edit.position = Vector2(get_viewport_rect().size.x - 120.0, offsetY - 10.0)
			current_display.append(edit)
			
			edit.pressed.connect(ChangeToElementsScene.bind(list_name))
		var create_use_button = func(offsetX, offsetY):
			var use = Button.new()
			$UI/Scroller.add_child(use)
			
			use.text = "Utiliser"
			use.size = Vector2(30, 20)
			use.position = Vector2(get_viewport_rect().size.x - 250.0, offsetY - 10.0)
			current_display.append(use)
			
			use.pressed.connect(ChangeToGameScene.bind(list_name))
			
		create_remove_button.call(offsetX, offsetY)
		create_edit_button.call(offsetX, offsetY)
		create_use_button.call(offsetX, offsetY)
		
var addlist = preload("res://Scenes/Listes/addlist.tscn")

func _ready() -> void:
	UpdateDisplay()
	
func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Menu/menu.tscn")

func _on_add_list_pressed() -> void:
	if get_children().size() >= 2:
		return
	
	add_child(addlist.instantiate())
