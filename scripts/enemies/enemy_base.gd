extends "res://scripts/card_pile.gd"

var debug_tag = "enemy_base.gd:  "

var hp = 10
var is_dead
var is_turn #= true
var did_turn 

var turn_moves = ["atk","def"]
var intent = 0

var combat_stats

var delay_timer=2
var delay_timer_max=2


func _ready():
	can_drop_cards = false
	can_add_cards = false
	add_to_group("enemy")
	combat_stats = Global.gen_combat_stats_obj()
	#print(debug_tag,combat_stats)
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
	pass
#end take_dmg

func set_intent():
	
	var moves_len = turn_moves.size()
	intent = randi() % moves_len
	$intent_sprite.frame = intent
	
	pass
#end set_intent

func do_move(delta):
	if !is_turn:return
	var move_to_do = turn_moves[intent]
	#delay_timer
	delay_timer-=delta
	if delay_timer>0:return
	delay_timer = delay_timer_max
	
	do_move_custom(move_to_do)
	is_turn = false
	did_turn = true
	pass
#end do_moves
func do_move_custom(move_name):
	if move_name =="atk":deal_dmg(5)
	
	pass
#end do_move_custom

func deal_dmg(dmg,do_anim=true):
	if do_anim: $AnimationPlayer.play("attack")
	yield(get_node("AnimationPlayer"), "animation_finished")
	Global.player.hp-=dmg
	print(debug_tag,"player hp",Global.player.hp)
	pass
#end deal_dmg
	
