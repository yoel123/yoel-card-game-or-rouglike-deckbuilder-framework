extends Node2D

#its just for testing stuff

func _ready():
	var hand = $hand
	
	hand.add_card(add_card_by_name("sword_strike"))
	hand.add_card(add_card_by_name("shield"))
		
	hand.add_card(add_card_by_name("sword_strike"))
	hand.add_card(add_card_by_name("shield"))
		
	hand.add_card(add_card_by_name("sword_strike"))
	hand.add_card(add_card_by_name("shield"))
	
	pass 
# end _ready


func add_card_by_name(card_name):
	var card_scene = load("res://scenes/cards/"+card_name+".tscn")
	card_scene = card_scene.instance()

	return card_scene
	pass
#end add_card_by_name
