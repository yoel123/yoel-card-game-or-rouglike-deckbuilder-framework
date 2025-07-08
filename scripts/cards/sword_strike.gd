extends "res://scripts/cards/card.gd"

func _ready():
	card_name = "sword_strike"
	can_drag = false
	card_attributes.dmg = 5
	._ready()
	pass

func do_card_action_custom(target):
	if target.has_method("take_dmg"): target.take_dmg(card_attributes.dmg)
	pass
#end do_card_action_custom
