extends Node2D

var cards=[]
var cards_scenes =[]

var margin_top = 30
var margin_left = 150
var space_between_cards = 170
var top_space_between_cards = 360
var max_cards_in_row = 5

func _ready():
	add_cards()
	pass


func _process(delta):
	visable_handle(delta)
	pass

func visable_handle(delta):
	if !visible:
		remove_all_cards()
		Global.combat_screen.screen = "main"
	else:Global.combat_screen.screen = "card_viewer"
	pass#end visable_handle

func add_cards():
	if cards.size() ==0:return
	for card in cards:
		var card_scene = load("res://scenes/cards/"+card+".tscn")
		card_scene = card_scene.instance()

		$ColorRect.add_child(card_scene)

		card_scene.position = position
		card_scene.view_only = true
		cards_scenes.append(card_scene)
		pass
	order_cards()
	
	pass
#end add_card

func remove_all_cards():
	for card in cards_scenes:
		if is_instance_valid(card):
			card.queue_free() 

	cards_scenes = []
	pass
#end remove_all_cards

func order_cards():
	var row = 0
	var column_counter = 0
	var i=0
	for card in cards_scenes:
		
		if !is_instance_valid(card):continue
		
		var is_new_row = column_counter >= max_cards_in_row
		
		if is_new_row:
			column_counter = 0
			row+=1
			
		card.position = position
		card.position.y += margin_top
		card.position.y += top_space_between_cards*row
		card.position.x += margin_left
		card.position.x += column_counter*space_between_cards
		
		column_counter+=1
		i+=1
		pass
	#end for
	pass




func _on_scroll_up_pressed():
	if Global.combat_screen.screen != "card_viewer":return
	scroll_y_do(-170)
	pass # Replace with function body.


func _on_scroll_down_pressed():
	if Global.combat_screen.screen != "card_viewer":return
	scroll_y_do(170)
	pass # Replace with function body.


func scroll_y_do(val):
	if cards_scenes.empty():return
	for card in cards_scenes:
		card.position.y += val


func _on_close_pressed():
	visible = false
	pass # Replace with function body.
