extends KinematicBody2D

var base_card =  preload("res://scenes/cards/card.tscn")

var cards = []
var hand_size = 6

var margin_top = 530
var margin_left = 20
var space_between_cards = 170

var card_angle = deg2rad(90)-0.5

#onready var 



func _ready():
	add_to_group("hand")

	pass 
#end _ready


func _process(delta):
	discard_hand_size()
	pass
#end _process
	
func add_card(card):
	cards.push_back(card)
	owner.call_deferred("add_child",card)
	card.position = position
	card.is_in_hand = true
	card.hand = self
	order_cards()
	add_card_custom(card)
	#print(cards.size())
	pass
#end add_card

func remove_card(card_to_remove):
	var i=0
	for card in cards:
		#if found card remove at position
		if card == card_to_remove:
			remove_card_custom(card_to_remove)
			cards[i].queue_free() 
			cards.remove(i)
		i+=1
		pass
	#end for
	order_cards()
	pass
#end remove_card

#incase you want to do somthing when removing a card (like add card do discard pile)
func remove_card_custom(card_to_remove):
	pass
#end remove_card_custom

func add_card_custom(card_to_remove):
	pass
#end add_card_custom

func order_cards():
	var i=0
	for card in cards:
		if !is_instance_valid(card):
			cards.remove(i)
			continue
		card.position = position
		card.position.y += margin_top
		card.position.x += margin_left
		card.position.x += (i*space_between_cards)
		i+=1
		pass
	#end for
	
	pass
#end order_cards

func discard_hand_size():
	if cards.size()>hand_size:
		remove_card(cards[cards.size()-1])
		pass
	pass
#end discard_hand_size

func disable_all_cards_in_hand(): for card in cards:card.disable = true
func enable_all_cards_in_hand(): for card in cards:card.disable = false




func _input(event):
	
	pass
#end _input
