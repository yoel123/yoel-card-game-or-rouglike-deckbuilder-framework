extends "res://scripts/card_pile.gd"

var debug_tag = "enemy_base.gd:  "

var hp = 10
var max_hp = 10
var is_dead
var is_turn #= true
var did_turn 

var turn_moves = ["atk","def"]
var intent = 0

var combat_stats

var delay_timer=1
var delay_timer_max=1


func _ready():
	can_drop_cards = false #cant drop a card on this pile
	can_add_cards = false #cant add cards to this pile
	#can only target this pile with cards
	add_to_group("enemy")
	combat_stats = Global.gen_combat_stats_obj()
	#print(debug_tag,combat_stats)
	set_hp_bar()
	._ready()
	pass
#end _ready

func _process(delta):
	._process(delta)
	do_move(delta)
	pass
#end _process

func take_dmg(dmg,type="normal"):
	
	if type=="normal": hp-=dmg
	
	if hp<=0:is_dead =true
	print(debug_tag,hp,"hp")
	if is_dead:print(debug_tag,"his dead!")
	
	set_hp_bar()
	pass
#end take_dmg

func set_intent():
	if is_dead:return
	#set a random move intent the enemy is planing to do on his turn
	var moves_len = turn_moves.size()
	intent = randi() % moves_len
	$intent_sprite.frame = intent
	
	pass
#end set_intent

func do_move(delta):
	if !is_turn:return
	if is_dead:
		did_turn_flags_do()#finish turn becuse its dead
		return
	#the move the enemy intends to do
	var move_to_do = turn_moves[intent]
	#delay_timer
	delay_timer-=delta
	if delay_timer>0:return
	delay_timer = delay_timer_max
	#do enemy move for his turn
	do_move_custom(move_to_do)
	did_turn_flags_do()
	pass
#end do_moves

func did_turn_flags_do():
	is_turn = false
	did_turn = true
	pass

func do_move_custom(move_name):
	if move_name =="atk":deal_dmg(5)
	
	pass
#end do_move_custom

func deal_dmg(dmg,do_anim=true):
	if do_anim: $AnimationPlayer.play("attack")
	yield(get_node("AnimationPlayer"), "animation_finished")
	Global.player_take_dmg(dmg)
	print(debug_tag,"player hp",Global.player.hp)
	pass
#end deal_dmg

func set_hp_bar():
	$hp_bar.value = hp
	$hp_bar.max_value = max_hp
	$hp_bar.get_node("Label").text = str(hp)+"/"+str(max_hp)
	pass#end set_hp_bar
	
