extends Node2D

var current_display : Array[Node] = []

const columns = 7	
const size = Vector2(80, 80)
const padding = Vector2(15, 15)

var shuffled_elements : Array

var reveal_scene = preload("res://Scenes/Game/reveal_card.tscn")

func CreateCards():
	for e in current_display:
		if e != null:
			e.queue_free()
		
	current_display.clear()
	shuffled_elements.clear()
	
	const start_offset = Vector2(80, 100)
	var offset = start_offset
	var current_column = 0
	
	var dict = Data.listes[Data.current_list_name].elements.keys()
	
	for elt_name in dict:
		var count = Data.listes[Data.current_list_name].elements[elt_name].count
		
		for i in range(count):
			shuffled_elements.append(Data.listes[Data.current_list_name].elements[elt_name].text)
		
	shuffled_elements.shuffle()

	for element_name in shuffled_elements:
		var card = Click2Button.new()
		$UI/Scroller.add_child(card)
		
		card.text = "?"
		card.size = size
		card.position = offset
		current_display.append(card)
		card.add_theme_font_size_override("font_size", 32)
		
		current_column += 1
		offset.x += size.x + padding.x
			
		if current_column >= columns:
			current_column = 0
			offset.y += size.y + padding.y
			offset.x = start_offset.x
	
		card.on_trigger.connect(RevealCard.bind(card, element_name))
	
func RevealCard(instance: Button, text: String):
	var scene = reveal_scene.instantiate()
	add_child(scene)
	scene.SetName(text)
	
	instance.queue_free()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$UI/Label.text = "LIST: " + Data.current_list_name
	CreateCards()

func _on_reload_on_trigger() -> void:
	CreateCards()

func _on_back_on_trigger() -> void:
	get_tree().change_scene_to_file("res://Scenes/Listes/listes.tscn")
