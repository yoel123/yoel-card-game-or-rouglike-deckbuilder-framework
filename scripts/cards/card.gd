extends KinematicBody2D


var card_name = "card"
var card_description ="some description"
var card_attributes = {"cost":0,"dmg":0,"def":0}
var card_target = "enemy"
var vfx_name = "none"
var once_per_combat_use


var disable
var view_only
var in_deack_editor
var can_drag = true
var dragging
var released
var mouse_hoverd
var targeting
var did_card_action

var is_in_hand
var move_to_hand
var hand

var move_to_hand_end_pos = Vector2(500,500)
var move_to_hand_add_to_hand_y_pos = 400

var can_target_timer = 0.5

func _ready():
	add_to_group("card")
	#if card_name=="card":
	#	$"card_container/card_atts/card_name".text = card_name
	#	$"card_container/card_atts/card_desc".text = card_description
	pass
#end _ready


func _process(delta):
	if disable:return
	if view_only:
		view_only_do()
		return
	if move_to_hand_do(delta):return #do nothing else when moving to hand
	drag_do()
	released_do()
	target_card(delta)


	pass
#end _process
func view_only_do():
	pass
	
func target_card(delta):

	if can_drag:return
	if !dragging || released:
		$line.clear_points()
		targeting = false
		#prevent bug where you can target after release
		if released:
			#the timer prevents targeting about half a second after realese
			#meaning you will only target once above the target
			can_target_timer-=delta
			if can_target_timer<0:
				Global.selected_card = null
				can_target_timer = 0.5
		
		return
	var mousePos = get_viewport().get_mouse_position()
	$line.clear_points()
	$line.add_point($line_start.position)
	$line.add_point(mousePos - position)
	targeting = true
	
	pass
#end target_card

func drag_do():	
	if dragging && can_drag && Global.selected_card ==self:
		 self.position =  get_viewport().get_mouse_position()
#end drag_do

func released_do():	
	#when a card is released not on any target
	if released: 
		if is_in_hand:hand.order_cards()
		#released = false
#end drag_do




func hover_do(event):	
	if view_only:return #no animation in view only mode
	if dragging && can_drag:return
	if !is_in_hand:return #dont do effects if not in hand
	if event is InputEventMouseMotion:
		var hover_sprite = $MarginContainer.get_rect().has_point(to_local(event.position)) 
		if hover_sprite:
			$"card_container/highlight".visible = true
			if is_in_hand && !mouse_hoverd: $AnimationPlayer.play("selected")
			mouse_hoverd = true
		else:
			$"card_container/highlight".visible = false
			if mouse_hoverd:$AnimationPlayer.play("deselected")
			mouse_hoverd = false
	pass
#end hover_do


func change_card_textures(bg_tex,texture_tex):
	$"card_container/card_bg".set_texture(bg_tex)
	$"card_container/card_texture".set_texture(texture_tex)
#end change_card_textures



func do_card_action_custom(target):
	pass

func do_card_action(target):
	if disable || view_only:return
	if did_card_action:
		remove_card()
		return
	print("card do somthing")
	do_card_action_custom(target)
	did_card_action = true
#end do_card_action

func remove_card():
	if is_in_hand:hand.remove_card(self)
#end remove_card


func move_to_hand_do(delta):
	if !move_to_hand:return false
	
	#interpulate and animate stuff
	var t = delta * 2.2
	position = position.linear_interpolate(Vector2(500,500), t)
	#when done set move to hand as false
	if position.y > move_to_hand_add_to_hand_y_pos:
		hand.add_card(self)
		move_to_hand = false
	return true
	pass
#end move_to_hand_do

func flip_card_anim_do():
	$card_container/card_back.visible = true
	$AnimationPlayer.play("flip")


func _input(event):
	if move_to_hand:return #dont react to clicks or anything while moving to hand
	hover_do(event)
	
	#check if player is dragging object
	if event is InputEventMouseButton:
		if( event.is_action_released("click")) :
			released = true
			dragging = false
		else:released = false
		#check if sprite is clicked
		var clicked_sprite = $MarginContainer.get_rect().has_point(to_local(event.position)) 
		if !clicked_sprite:return
		#then check if left mouce btn is down
		if  event.button_index == BUTTON_LEFT && event.pressed:
			dragging = true
			Global.selected_card = self
		elif(event.button_index == BUTTON_LEFT and not event.pressed) :
			if dragging: released = true
			dragging = false
			Global.selected_card = null

#end _input
