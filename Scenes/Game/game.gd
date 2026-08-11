extends Node2D

#Button need to double click
var exit_confirm = false
var reload_confirm = false

var current_display : Array[Node] = []

const columns = 6
var shuffled_elements : Array

var reveal_scene = preload("res://Scenes/Game/reveal_card.tscn")

func CreateCards():
	for e in current_display:
		if e != null:
			e.queue_free()
		
	current_display.clear()
	
	const start_offset = Vector2(80, 100)
	var offset = start_offset
	var current_column = 0
	
	shuffled_elements = Data.listes[Data.current_list_name].elements.keys()
	shuffled_elements.shuffle()
	
	const size = Vector2(100, 100)
	const padding = Vector2(20, 20)
	
	const random_text = [":3", ";3", ":)", ":>", ">w<", "uWu", "oWo", ";)", ";>"]
	
	for element_name in shuffled_elements:
		var card = Button.new()
		$UI/Scroller.add_child(card)
		
		card.text = random_text.pick_random()
		card.size = size
		card.position = offset
		current_display.append(card)
			
		current_column += 1
		offset.x += size.x + padding.x
			
		if current_column >= columns:
			current_column = 0
			offset.y += size.y + padding.y
			offset.x = start_offset.x
	
		card.pressed.connect(RevealCard.bind(card, element_name))
	
func RevealCard(instance: Button, text: String):
	var scene = reveal_scene.instantiate()
	add_child(scene)
	scene.SetName(text)
	
	instance.queue_free()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$UI/Label.text = "LIST: " + Data.current_list_name
	CreateCards()

func _on_back_pressed() -> void:
	if exit_confirm:
		exit_confirm = false
		get_tree().change_scene_to_file("res://Scenes/Listes/listes.tscn")
		return
	
	exit_confirm = true
	$LeaveTimer.start()
func _on_leave_timer_timeout() -> void:
	exit_confirm = false

func _on_reload_pressed() -> void:
	if reload_confirm:
		reload_confirm = false
		CreateCards()
		return
	
	reload_confirm = true
	$ReloadTimer.start()
func _on_reload_timer_timeout() -> void:
	reload_confirm = false
