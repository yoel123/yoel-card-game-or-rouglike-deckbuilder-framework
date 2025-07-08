extends Node

var player_turn = true
var player_turn_phase = "init"
var hand
var player_deck

var enemies = ["enemy_base","enemy_base"]
var enemies_scenes = []
var current_enemy_turn = 0
var enemy_margin_left = 150
var enemy_margin_top = 50

var wait_timer

var perent



func _ready():
	#get hand
	hand = get_tree().get_nodes_in_group("hand")[0]
	enemies_scenes = get_tree().get_nodes_in_group("enemy")
	
	pass 
#end _ready

func _process(delta):
	disable_player(delta)
	player_turn_manger(delta)
	do_enemy_turns()
	pass
#end 	_process

func disable_player(delta):
	if player_turn:
		return
	hand.disable_all_cards_in_hand()
	pass
#end disable_palayer

func init_combat():
	#add enemy scenes
	enemies_scenes = get_tree().get_nodes_in_group("enemy")
	pass
#end init_combat

func init_player_stats():
		
	Global.player_combat_stats = Global.gen_combat_stats_obj()
	Global.player_combat_stats.energy_max = Global.player.energy_max

	
	pass
#end init_player_stats

func start_player_turn():
	#replenish energy
	Global.player_combat_stats.energy = Global.player_combat_stats.energy_max
	#remove block (unless dont remove bock is bigger then 0)
	if Global.player_combat_stats.dont_remove_def == 0:
		Global.player_combat_stats.def = 0 
	else: 
		#dincrament dont_remove_def stat/effect
		Global.player_combat_stats.dont_remove_def-=1
	#check relics
	#check stats (like regen etc)
	
	#set enemys intents
	set_enemies_intents()
	
	#show pass turn btn
	Global.combat_screen.pass_turn_btn.visible = true
	
	pass
#end start_player_turn():

func player_turn_manger(delta):
	if !player_turn:return
	if player_turn_phase =="init":
		start_player_turn()
		player_turn_phase = "main"
		pass
	
	if player_turn_phase =="main":
		hand.enable_all_cards_in_hand()
		pass
	
	if player_turn_phase =="end":
		player_turn = false #pass turn to enemies
		current_enemy_turn = 0 #start from first enemy
		#do some animation or sound
		pass
	
	
	pass
#end player_turn_manger

func end_player_turn():
	#discard hand
	pass
#end

func gen_enemies():
	pass
#end gen_enemies

func set_enemies_intents():
	if enemies_scenes.size()>0:
		for enemy in enemies_scenes:
			enemy.set_intent()
	pass
#end set_enemies_intents

func do_enemy_turns():
	if player_turn:return
	#if all enemys did thier turn return turn to player
	var did_all_enemies_do_thier_turn = current_enemy_turn>enemies_scenes.size()-1
	if  did_all_enemies_do_thier_turn:
		player_turn = true #make this a func
		player_turn_phase ="init"
		return
	#get current enemy start its turn
	var curent_enemy = enemies_scenes[current_enemy_turn]
	curent_enemy.is_turn=true
	#if curent enemy does its turn
	#reset flags and move to next enemy
	if curent_enemy.did_turn:
		curent_enemy.is_turn = false #not this enemy turn anymore
		curent_enemy.did_turn = false #reset did turn
		current_enemy_turn+=1 #pass turn to next enemy
	
	pass
#end do_enemy_turns

