extends "res://scripts/cards/card.gd"

func _ready():
	card_name = "shield"
	can_drag = true
	card_attributes.def = 5
	._ready()
	pass

func do_card_action_custom(target):
	print("do def: ",card_attributes.def)
	pass
#end do_card_action_custom
