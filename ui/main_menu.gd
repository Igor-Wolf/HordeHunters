extends CanvasLayer

#@export var options_template: PackedScene

@onready var bgm_audio = $Audio/AudioStreamPlayer2D
@onready var sfx_audio = %SFX

@export_category("Audio")
@export var sfx_list: Array = [preload("res://addons/Audio/sfx/cursor_style_2.ogg"),
								preload("res://addons/Audio/sfx/back_style_2_003.ogg")]
								
@onready var last_click_time = 0.0
var button_focused
var input_processed = false
const CLICK_DEBOUNCE_TIME = 0.2

func _ready():
	# Tratar o volume
	GameManager.connect("bgm_volume_changed", Callable(self, "_update_bgm_volume"))
	GameManager.connect("sfx_volume_changed", Callable(self, "_update_sfx_volume"))

	# Set initial volume
	_update_bgm_volume(GameManager.bgm_volume)
	_update_sfx_volume(GameManager.sfx_volume)
	
	# Poder selecionar os botões com controle e teclado
	if Input.is_joy_known(0):
		$BottonPanel/MainMenu/NewGame.grab_focus()

func _process(delta):
	
	button_focused = get_viewport().gui_get_focus_owner()	
	if !button_focused:		
		if Input.is_joy_known(0):
			%NewGame.grab_focus()
		
	last_click_time -= delta
	if last_click_time < 0:
		last_click_time = 0

	if Input.is_action_just_pressed("confirm_button") or Input.is_action_just_pressed("ui_accept") or Input.is_mouse_button_pressed(0):
		if last_click_time <= 0:
			_on_confirm_button()
			sfx_audio.stream = sfx_list[1]
			sfx_audio.play()
			last_click_time = CLICK_DEBOUNCE_TIME
			
	if Input.is_action_just_pressed("move_up") or Input.is_action_just_pressed("move_down") or Input.is_action_just_pressed("move_left") or Input.is_action_just_pressed("move_right"):
		sfx_menu()

func _on_new_game_pressed():
	# Mudar cena
	#get_tree().change_scene_to_file("res://level1.tscn")
	get_node("HuntersLodge").show()
	hide()
	
func _on_options_pressed():
	 
	# Criar OptionsUI    
	get_node("OptionsMainMenu").show()
	if Input.is_joy_known(0):
		get_node("OptionsMainMenu").get_node("%BGM").grab_focus()
	hide()
	
	
func _on_credits_pressed():
	
	get_node("CreditsUi").show()
	if Input.is_joy_known(0):
		get_node("CreditsUi").last_click_time =0.1
		get_node("CreditsUi").get_node("%ReturnCredits").grab_focus()	
	hide()
	
func _on_achievements_pressed():
	get_node("AchievementsUi").show()
	get_node("AchievementsUi").ativo = true
	get_node("AchievementsUi").cont = 0.1
	get_node("AchievementsUi").process_mode = Node.PROCESS_MODE_INHERIT
	
	hide()

func _on_quit_pressed():
	get_tree().quit()

func _on_confirm_button():
	var focused_button = get_viewport().gui_get_focus_owner()
	if focused_button == $BottonPanel/MainMenu/NewGame:
		_on_new_game_pressed()
	elif focused_button == $BottonPanel/MainMenu/Options:
		_on_options_pressed()
	elif focused_button == $BottonPanel/MainMenu/Credits:
		_on_credits_pressed()
	elif focused_button == $BottonPanel/MainMenu/Quit:
		_on_quit_pressed()
	elif focused_button == $BottonPanel/MainMenu/Achievements:
		_on_achievements_pressed()

func _input(event):
	if event.is_action_released("confirm_button") or event.is_action_released("ui_accept"):
		input_processed = false

#-------------------------------------------------- Alterar o volume

func _update_bgm_volume(value):
	bgm_audio.volume_db = linear_to_db(value)

func _update_sfx_volume(value):
	sfx_audio.volume_db = linear_to_db(value)

func linear_to_db(value):
	return 20 * log(value) / log(10)

func sfx_menu():
	sfx_audio.stream = sfx_list[0]
	sfx_audio.play()
	

#-------------------------------------------------- Mouse hover sfx
func _on_new_game_mouse_entered():
	sfx_menu()


func _on_options_mouse_entered():
	sfx_menu()


func _on_credits_mouse_entered():
	sfx_menu()


func _on_quit_mouse_entered():
	sfx_menu()
	

func _on_achievements_mouse_entered():
	sfx_menu()
