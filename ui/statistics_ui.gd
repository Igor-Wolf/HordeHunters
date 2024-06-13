class_name StatiscsUi
extends CanvasLayer

@onready var time_label: Label = %TimeLabel
@onready var monsters_label: Label = %MonstersLabel
@onready var meat_label: Label = %MeatLabel
@onready var exp_earned: Label = %ExpEarned
@onready var total_gold: Label = %TotalGold

@onready var health_label: Label = %Health
@onready var max_health_label: Label = %MaxHealth
@onready var str_label: Label = %Str
@onready var speed_label: Label = %Speed
@onready var class_label: Label = %ClassLabel
@onready var armor_label: Label = %Armor
@onready var magic_label: Label = %Magic

var input_enabled = false
var ativo = true
var cont = 0


func _ready():
	if Input.is_joy_known(0):	
		%Return.grab_focus()
	class_label.text = get_parent().get_node("Player").class_char
	_scene_load_delay()

func _process(delta):	
	cont -= delta
	
	
	time_label.text = GameManager.time_elapsed_string
	monsters_label.text = str(GameManager.monsters_defeated_counter)
	meat_label.text = str(GameManager.meat_counter)
	total_gold.text = str(GameManager.gold_counter)
	exp_earned.text = str(GameManager.curent_experience)
		
	health_label.text = str(get_parent().get_node("Player").health)
	max_health_label.text = str(get_parent().get_node("Player").max_health)
	str_label.text = str(get_parent().get_node("Player").sword_damage)
	speed_label.text = str(get_parent().get_node("Player").speed)
	armor_label.text = str(get_parent().get_node("Player").armor)
	magic_label.text = str(get_parent().get_node("Player").magic)

	if input_enabled:  # Verifique se a entrada está habilitada
		if Input.is_action_just_pressed("confirm_button") or Input.is_action_just_pressed("ui_accept") or Input.is_mouse_button_pressed(0):
			_on_confirm_button()
	
	if cont<=0 and ativo:
		ativo = false
		
			

func _on_confirm_button():
	
	if self.visible and ativo == false:
		var focused_button = get_viewport().gui_get_focus_owner()
		if focused_button == %Return:
			_on_return_pressed()
		%Return.grab_focus()
		

func _on_return_pressed():
	#release_all_focus()
	
	get_parent().get_node("PauseMenu").show()
	get_parent().get_node("PauseMenu").get_node("%Statistics").grab_focus()
	
	hide()

func _scene_load_delay() -> void:
	#await get_tree().create_timer(0.5).timeout  # Tempo de espera conforme necessário
	input_enabled = true
	#release_all_focus()

func release_all_focus():
	# Itera através de todos os filhos e libera o foco
	for child in get_children():
		if child is Control:
			child.release_focus()


func _on_return_mouse_entered():
	get_parent().get_node("PauseMenu").sfx_menu()
