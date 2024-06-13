extends CanvasLayer

var button_focused
@onready var last_click_time = 0.0
@onready var scroll: ScrollContainer = $Panel2/ScrollContainer

func _process(delta):
	button_focused = get_viewport().gui_get_focus_owner()	
	if !button_focused:
		if Input.is_joy_known(0):
			%ReturnCredits.grab_focus()
			
			
	last_click_time -= delta
	if last_click_time < 0:
		last_click_time = 0
#
	if Input.is_action_just_pressed("confirm_button") or Input.is_action_just_pressed("ui_accept") or Input.is_mouse_button_pressed(0):
		if last_click_time <= 0:
			_on_confirm_button()
			
			
	if Input.is_action_just_pressed("scroll_up"):
		scroll.scroll_vertical = scroll.get_v_scroll_bar().value - 50
		
	if Input.is_action_just_pressed("scroll_down"):
		scroll.scroll_vertical = scroll.get_v_scroll_bar().value + 50
		
		
		
func _on_confirm_button():
	var focused_button = get_viewport().gui_get_focus_owner()         
	if focused_button == %ReturnCredits:
		
		_on_return_pressed()		

func _on_return_pressed():
	get_parent().show()
	hide()	


func _on_return_mouse_entered():
	get_parent().sfx_menu()


func _on_cheat_pressed():
	GameManager.gold_counter += 100
