extends CanvasLayer


@onready var scroll_container: ScrollContainer = $Panel2/ScrollContainer
@onready var panel_labels: Array = [$Panel2/ScrollContainer/VBoxContainer/a1/Panel,
$Panel2/ScrollContainer/VBoxContainer/a2/Panel,
$Panel2/ScrollContainer/VBoxContainer/a3/Panel,
$Panel2/ScrollContainer/VBoxContainer/a4/Panel,
$Panel2/ScrollContainer/VBoxContainer/a5/Panel,
$Panel2/ScrollContainer/VBoxContainer/a6/Panel,
$Panel2/ScrollContainer/VBoxContainer/a7/Panel]
var ativo = false
var cont = 0

func _process(delta):
	
	cont -= delta
	
	if cont<=0 and ativo:
		ativo = false
	
	if Input.is_joy_known(0):
		$Panel2/Return.grab_focus()	
	
	if AchievementsManager.achievements_unlocked[0] == 1:
		panel_labels[0].hide()
	
	if AchievementsManager.achievements_unlocked[1] == 1:
		panel_labels[1].hide()
		
	if AchievementsManager.achievements_unlocked[2] == 1:
		panel_labels[2].hide()
		
	if AchievementsManager.achievements_unlocked[3] == 1:
		panel_labels[3].hide()
		
	if AchievementsManager.achievements_unlocked[4] == 1:
		panel_labels[4].hide()
		
	if AchievementsManager.achievements_unlocked[5] == 1:
		panel_labels[5].hide()
		
	if AchievementsManager.achievements_unlocked[6] == 1:
		panel_labels[6].hide()
		
	if Input.is_action_just_pressed("confirm_button") or Input.is_action_just_pressed("ui_accept"):
		_on_confirm_button()
		
	if Input.is_action_just_pressed("scroll_up"):
		scroll_container.scroll_vertical = scroll_container.get_v_scroll_bar().value -50
		
	if Input.is_action_just_pressed("scroll_down"):
		scroll_container.scroll_vertical = scroll_container.get_v_scroll_bar().value +50
	


func _on_confirm_button():
	if self.visible and ativo == false:
		var focused_button = get_viewport().gui_get_focus_owner()         
		if focused_button == $Panel2/Return:
			_on_return_pressed()


func _on_return_pressed():
	
	get_parent().show()
	self.process_mode = Node.PROCESS_MODE_DISABLED
	hide()


func _on_return_mouse_entered():
	get_parent().sfx_menu()
