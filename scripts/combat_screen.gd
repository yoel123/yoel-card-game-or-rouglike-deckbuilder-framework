extends Node2D


var combat_manger
var pass_turn_btn

func _ready():
	combat_manger = $combat_manger
	var hand = $hand
	combat_manger.init_player_stats()
	Global.combat_screen = self
	pass_turn_btn = $pass_turn_btn
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


func _on_pass_turn_btn_pressed():
	
	if combat_manger.player_turn:
		print("pass_turn")
		pass_turn_btn.visible = false
		combat_manger.player_turn_phase ="end"
	pass # Replace with function body.
