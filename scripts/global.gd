extends Node

var dragging_a_card

var selected_card
var player = {"max_hp":10,"hp":10,"energy_max":3}
var player_combat_stats
var player_cards = {}

var enemies_to_fight

var world_map
var combat_screen

func _ready():
	pass
#end _ready

func _process(delta):
	pass
#end _process

func gen_combat_stats_obj():
	
	return {"energy_max":0,"energy":0,"card_draw":2,"def":0,"str":0,"dex":0,"vulnerable":0,"stun":0
	,"poison":0,"armor":0,"fregile_armor":0,"spikes":0,"dont_remove_def":0,
	"dont_discard_hand":0}
	
	pass
#end gen_combat_stats_obj


func player_take_dmg(dmg,type="normal"):
	player.hp-=dmg
	combat_screen.player_hpbar.value = player.hp
	combat_screen.player_hpbar.max_value = player.max_hp
	combat_screen.player_hpbar.get_node("Label").text = "player hp:"+str(player.hp)+"/"+str( player.max_hp)
	pass#end player_take_dmg


