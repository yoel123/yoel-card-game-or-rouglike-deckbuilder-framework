extends KinematicBody2D

var pile_name = "drop_area"
var cards = []
#can you drop cards on this pile
export var can_drop_cards = true
#does droping/targeting the card activated the dards action
export var do_card_action_when_droped = true
#can be targeted by cards that target stuff
export var can_be_targeted_by_cards = true
#will add cards to pile cards array when droped/targeted
export var can_add_cards = true
#if card is place show it on top of pile face up
export var show_top_card = false
var top_card_scene

export(NodePath) var card_viewer

var disable
var has_mouse_focus = false
var clicked
var clicked_times = 0
var click_reset_counter = 0
export var click_do_action = "draw_card_to_hand"#"open_card_viewer"






func _ready():
	if card_viewer: card_viewer = get_node(card_viewer)
	
	$Area2D.connect("mouse_entered", self, "set", ["has_mouse_focus", true])
	$Area2D.connect("mouse_exited", self, "set", ["has_mouse_focus", false])
#end _ready

func _process(delta):
	if disable:return
	cards_coliding_do(delta)
	do_targeting_card_action(delta)
	click_do(delta)
	pass
#end _process

#when a card targets this pile
func do_targeting_card_action(delta):
	if !can_be_targeted_by_cards:return
	
	var mouse_hovering_and_player_selected_a_card = has_mouse_focus && Global.selected_card 
	
	if mouse_hovering_and_player_selected_a_card:
		var is_valid_instance_and_in_card_group = is_instance_valid(Global.selected_card) && Global.selected_card.is_in_group("card")
		if is_valid_instance_and_in_card_group:
			place_card(Global.selected_card)
			do_targeting_card_action_costum(Global.selected_card)
#end do_targeting_card_action

func do_targeting_card_action_costum(card):
	pass
#end do_targeting_card_action_costum

func add_card(card):
	if !can_add_cards:return
	#print("add card")
	cards.push_back(card)
	pass
#end add_card

func remove_card(card_to_remove):
	var i=0
	for card in cards:
		#if found card remove at position
		if card == card_to_remove:
			cards[i].queue_free() 
			cards.remove(i)
		i+=1
		pass
	#end for
	pass
#end remove_card

#when card is droped on this pile
func cards_coliding_do(delta):
	if !can_drop_cards:return
	var card_coliding = $Area2D.get_overlapping_areas()
	#check if card is coliding
	if card_coliding:
		#loop all coliding card
		for c in card_coliding:
			#current card
			var card = c.get_parent()
			if !card.is_in_group("card"):continue #make sure its a card
			#place card only when user releases mouse btn
			if card.released:place_card(card)
#end dice_coliding_do

#what happens when a card is released over this pile
func place_card(card):
	#only none disabled cards can be placed
	if card.view_only || card.disable || card.move_to_hand:return
	if !card.is_in_hand:return #card can be placed only from hand
	#print("placed card")
	#save the card name
	add_card(card.card_name)
	#do card action (and pass self as card target)
	if do_card_action_when_droped:
		card.do_card_action(self)
	place_card_costum(card)
	#remove card from hand
	if card.is_in_hand:card.hand.remove_card(card)
	
	if show_top_card:show_top_card_do()
		
	pass
#end place_card

func show_top_card_do():
	if top_card_scene:return
	var card_name = cards.pop_back()
	var card_scene = load("res://scenes/cards/"+card_name+".tscn")
	card_scene = card_scene.instance()
	owner.call_deferred("add_child",card_scene)
	card_scene.view_only = true
	card_scene.position = self.position
	top_card_scene = card_scene
	can_drop_cards = false #dont drop cards after you put a card on it
	pass

func place_card_costum(card):

	pass
#end place_card_costum

func click_do(delta):
	
	reset_double_click_timer(delta)
	
	#if double clicking this pile opens the cards viewer
	#(for viewing cards inside pile)
	if click_do_action == "open_card_viewer" && double_click(delta):
		if card_viewer: open_card_viewer_do()
			
	if click_do_action == "draw_card_to_hand" && double_click(delta):
		draw_top_card_to_hand()
	pass
#end click_do

func reset_double_click_timer(delta):
	#reset the counter for the double click
	click_reset_counter+=delta #incrament timer
	if click_reset_counter >2: #check timer
		clicked_times = 0
		click_reset_counter = 0
	pass

func double_click(delta):
	if clicked_times >1: #double click
		clicked_times = 0
		return true
	return false
	pass

func open_card_viewer_do():
	card_viewer.visible = true
	card_viewer.cards = cards.duplicate()
	card_viewer.add_cards()
	pass
#end open_card_viewer_do

func draw_top_card_to_hand():
	#no cards dont draw
	if cards.size() ==0: return
	#print( cards.size(),"pile size")
	#create card by card name
	var card_name = cards.pop_back()
	var card_scene = load("res://scenes/cards/"+card_name+".tscn")
	card_scene = card_scene.instance()
	owner.call_deferred("add_child",card_scene)
	#get hand
	var hand = get_tree().get_nodes_in_group("hand")[0]
	#set card hand att
	card_scene.hand = hand
	#tell it to move to hand
	card_scene.move_to_hand = true
	card_scene.flip_card_anim_do()
	clicked = false
	pass
#end draw_top_card_to_hand

func check_card_cost(card):
	#if card energy >player_combat_stats.energy return false
	#reduce energy
	return true
	pass
#end check_card_cost

func add_modifiers_to_card_effect(card):
	pass

func _input(event):

	#check if player is dragging object
	if event is InputEventMouseButton:
		if event.is_action_released("click") && has_mouse_focus :
			clicked = true
			clicked_times+=1
		else:
			clicked = false
			pass
	pass
