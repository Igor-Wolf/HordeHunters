class_name PauseUI
extends CanvasLayer

@export var options_template: PackedScene
#@onready var options: Options = options_template.instantiate()

@onready var sfx_audio = get_parent().get_node("%SFX")

@export_category("Audio")
@export var sfx_list: Array = [preload("res://addons/Audio/sfx/cursor_style_2.ogg"),
								preload("res://addons/Audio/sfx/back_style_2_003.ogg")]
								
var button_focused
var came_from_level = false

func _ready():
	
		
	# Tratar o volume
	GameManager.connect("bgm_volume_changed", Callable(self, "_update_bgm_volume"))
	GameManager.connect("sfx_volume_changed", Callable(self, "_update_sfx_volume"))

	# Set initial volume
	#_update_bgm_volume(GameManager.bgm_volume)
	_update_sfx_volume(GameManager.sfx_volume)

func _process(delta):
	button_focused = get_viewport().gui_get_focus_owner()
	
	if !button_focused and came_from_level:
		
		if Input.is_joy_known(0):
			
			%Statistics.grab_focus()
			
		
	
	if Input.is_action_just_pressed("confirm_button") or Input.is_action_just_pressed("ui_accept") or Input.is_mouse_button_pressed(0):
		_on_confirm_button()
		confirm_sfx()
			
	if Input.is_action_just_pressed("move_up") or Input.is_action_just_pressed("move_down") or Input.is_action_just_pressed("move_left") or Input.is_action_just_pressed("move_right"):
		sfx_menu()

func _on_statistics_pressed():
	if came_from_level:
	
		get_parent().get_node("%StatisticsUi").ativo = true		
		get_parent().get_node("%StatisticsUi").cont = 0.1	
		get_parent().get_node("%StatisticsUi").show()
		if Input.is_joy_known(0):
			get_parent().get_node("%StatisticsUi").get_node("%Return").grab_focus()	
		
		hide()

func _on_options_pressed():	
	get_parent().get_node("%Options").show()
	if Input.is_joy_known(0):
		get_parent().get_node("%Options").get_node("%BGM").grab_focus()
	hide()
	
func _on_achievements_pressed():
	get_parent().get_node("%AchievementsUi").ativo = true
	get_parent().get_node("%AchievementsUi").cont = 0.1			
	get_parent().get_node("%AchievementsUi").show()
	get_parent().get_node("%AchievementsUi").process_mode = Node.PROCESS_MODE_ALWAYS
	
	
	if Input.is_joy_known(0):
		get_parent().get_node("%AchievementsUi").get_node("%Return").grab_focus()
	hide()

func _on_resume_pressed():
	get_tree().paused = false
	GameManager.close_menu()
	came_from_level = false
	hide()

func _on_quit_pressed():
	get_tree().paused = false
	hide()
	GameManager.end_game()

	
func _on_confirm_button():
	var focused_button = get_viewport().gui_get_focus_owner()
	if focused_button == %Options:
		_on_options_pressed()
	elif focused_button == %Resume:
		_on_resume_pressed()
	elif focused_button == %Quit:
		_on_quit_pressed()
	elif focused_button == %Statistics:
		_on_statistics_pressed()
	elif focused_button == %Achievements:
		_on_achievements_pressed()


	
#-------------------------------------------------- Alterar o volume

#func _update_bgm_volume(value):
	#bgm_audio.volume_db = linear_to_db(value)

func _update_sfx_volume(value):
	sfx_audio.volume_db = linear_to_db(value)

func linear_to_db(value):
	return 20 * log(value) / log(10)

func sfx_menu():
	sfx_audio.stream = sfx_list[0]
	if GameManager.menu_open:
		sfx_audio.play()

func confirm_sfx():
	sfx_audio.stream = sfx_list[1]
	if GameManager.menu_open:
		sfx_audio.play()

#-------------------------------------------------- Mouse hover sfx

func _on_statistics_mouse_entered():
	sfx_menu()

func _on_options_mouse_entered():
	sfx_menu()

func _on_achievements_mouse_entered():
	sfx_menu()

func _on_resume_mouse_entered():
	sfx_menu()

func _on_quit_mouse_entered():
	sfx_menu()

func set_pause_menu_focus():
	

	if Input.is_joy_known(0):
		%Statistics.grab_focus()



