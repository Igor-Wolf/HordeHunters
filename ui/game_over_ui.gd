class_name	GameOverUI
extends CanvasLayer

@onready var time_label: Label = %TimeLabel
@onready var monsters_label: Label = %MonstersLabel
@onready var meat_label: Label = %MeatLabel
@onready var exp_earned: Label = %ExpEarned
@onready var total_gold: Label = %TotalGold


@export var restart_delay: float = 5.0
var restart_cooldown: float
@onready var bgm_audio  = get_parent().get_node("Audio").get_child(1)

func _ready():
	
	GameManager.connect("bgm_volume_changed", Callable(self, "_update_bgm_volume"))
	_update_bgm_volume(GameManager.bgm_volume)
	bgm_audio.play()
	if Input.is_joy_known(0):	
		%Retry.grab_focus()
	time_label.text = GameManager.time_elapsed_string
	monsters_label.text = str(GameManager.monsters_defeated_counter)
	meat_label.text = str(GameManager.meat_counter)
	total_gold.text = str(GameManager.gold_counter)
	exp_earned.text = str(GameManager.curent_experience)
	restart_cooldown = restart_delay
	get_parent().get_node("Audio").get_child(0).queue_free()
	
	
	get_tree().paused = true
	
func _process(delta):
	if Input.is_action_just_pressed("confirm_button"):
		_on_confirm_button()
		
	#restart_cooldown -= delta
	#if restart_cooldown <= 0.0:
		#restart_game()
		
func restart_game():
	GameManager.reset()
	get_tree().reload_current_scene()

#------------------------------------------------------ Buttons

func _on_retry_pressed():
	restart_game()
	GameManager.close_menu()
	pass # Replace with function body.

func _on_main_menu_pressed():
	get_tree().paused = false
	GameManager.close_menu()
	get_tree().change_scene_to_file("res://ui/main_menu.tscn")
	
	pass # Replace with function body.

func _on_confirm_button():
	var focused_button =  get_viewport().gui_get_focus_owner()	     	
	if focused_button == %Retry:
		_on_retry_pressed()
	elif focused_button == %MainMenu:
		GameManager.reset()
		_on_main_menu_pressed()
	


func _on_retry_mouse_entered():
	get_parent().get_node("PauseMenu").sfx_menu()


func _on_main_menu_mouse_entered():
	get_parent().get_node("PauseMenu").sfx_menu()
	
#-------------------------------------------------- Alterar o volume

func _update_bgm_volume(value):
	bgm_audio.volume_db = linear_to_db(value)
	
func linear_to_db(value):
	return 20 * log(value) / log(10)
