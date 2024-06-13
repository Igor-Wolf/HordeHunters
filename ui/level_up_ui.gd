extends CanvasLayer

# Exporte a lista de botões e suas posições
@export var button_list: Array[NodePath] = []
@export var button_positions: Array[Vector2] = []

func _ready():
	GameManager.level_up.connect(update_buttons)
	
func _process(delta):
	
	if Input.is_action_just_pressed("confirm_button") or Input.is_action_just_pressed("ui_accept"):
		_on_confirm_button()
	
func update_buttons():
	get_tree().paused = true
	show()
	# Crie uma cópia da lista de botões para manipulação
	var available_buttons = button_list.duplicate()
	
	# Desative todos os botões
	for button_path in button_list:
		var button = get_node(button_path) as Button
		if button:
			button.disabled = true
			button.hide()

	# Seleciona aleatoriamente três botões da lista
	var chosen_buttons = []
	while chosen_buttons.size() < 3 and available_buttons.size() > 0:
		var random_index = randi() % available_buttons.size()
		var button_path = available_buttons[random_index]
		var button = get_node(button_path) as Button
		if button:
			
			if button.text == "RITUAL" and GameManager.power_ups[5] >4 or button.text == "RITUAL" and GameManager.shop_power_ups_p1[0]==0:
				pass
			elif button.text == "FLAME CUT" and GameManager.shop_power_ups_p1[1]==0:
				pass
			elif button.text == "WARRIO'S MIGHT" and GameManager.shop_power_ups_p1[2]==0:
				pass
			elif button.text == "CHARGE" and GameManager.shop_power_ups_p1[3]==0:
				pass
			elif button.text == "ETHERNAL SHILD" and GameManager.shop_power_ups_p1[4]==0 or button.text == "RITUAL" and GameManager.power_ups[9] >4 :
				pass
			else:
				if Input.is_joy_known(0) and chosen_buttons.size() <1:
					button.grab_focus()
				var position_index = chosen_buttons.size() # posição indexada para os botões escolhidos
				var position = button_positions[position_index]
				button.position = position
				chosen_buttons.append(button)
				available_buttons.erase(button_path)

	# Ativa e mostra os botões escolhidos
	for button in chosen_buttons:
		button.disabled = false
		button.show()

func _on_str_pressed():
	get_tree().paused = false
	get_parent().sword_damage += 1 
	GameManager.power_ups[0] += 1
	GameManager.close_menu()
	hide()


func _on_health_pressed():
	get_tree().paused = false
	get_parent().max_health += 10 
	GameManager.power_ups[1] += 1
	GameManager.close_menu()
	hide()

func _on_armor_pressed():	
	
	get_tree().paused = false
	get_parent().armor += 1 
	GameManager.power_ups[2] += 1
	GameManager.close_menu()
	hide()

func _on_speed_pressed():
	get_tree().paused = false
	get_parent().speed += 0.1 
	GameManager.power_ups[3] += 1
	GameManager.close_menu()
	hide()
func _on_magic_pressed():
	
	get_tree().paused = false
	get_parent().magic += 1 
	GameManager.power_ups[4] += 1
	GameManager.close_menu()
	hide()
	
func _on_ritual_pressed():
	#Ritual	
	get_tree().paused = false	
	get_parent().ritual_damage *= 2 
	GameManager.power_ups[5] += 1
	GameManager.close_menu()
	hide()
	
func _on_flame_cut_pressed():	
	#Flame Cut
	get_tree().paused = false	
	get_parent().flame_damage += 2 
	GameManager.power_ups[6] += 1	
	get_tree().paused = false
	GameManager.close_menu()
	hide()
	
func _on_warrios_might_pressed():
	#Warriors Might
	get_tree().paused = false	
	get_parent().knockback += 1 
	GameManager.power_ups[7] += 1	
	get_tree().paused = false
	GameManager.close_menu()
	hide()
	
func _on_charge_pressed():
	#Charge
	get_tree().paused = false	
	get_parent().dash_damage += 1 
	GameManager.power_ups[8] += 1	
	get_tree().paused = false
	GameManager.close_menu()
	hide()
	
func _on_ethernal_shild_pressed():
	#Ethernal Shild
	get_tree().paused = false	
	get_parent().shild_damage += 1 
	GameManager.power_ups[9] += 1	
	get_tree().paused = false
	GameManager.close_menu()
	hide()

func _on_confirm_button():
	var focused_button = get_viewport().gui_get_focus_owner()         
	if focused_button == %Armor:		
		_on_armor_pressed()
	elif focused_button == %Speed:		
		_on_speed_pressed()
	elif focused_button == %Str:		
		_on_str_pressed()
	elif focused_button == %Ritual:		
		_on_ritual_pressed()
	elif focused_button == %FlameCut:		
		_on_flame_cut_pressed()
	elif focused_button == %Magic:		
		_on_magic_pressed()
	elif focused_button ==%Health:		
		_on_health_pressed()
	elif focused_button ==%WarriosMight:		
		_on_warrios_might_pressed()
	elif focused_button ==%Charge:		
		_on_charge_pressed()
	elif focused_button ==%EthernalShild:		
		_on_ethernal_shild_pressed()



#-------------------------------------------------- Mouse hover sfx
func _on_armor_mouse_entered():
	get_parent().get_parent().get_node("PauseMenu").sfx_menu()


func _on_speed_mouse_entered():
	get_parent().get_parent().get_node("PauseMenu").sfx_menu()


func _on_str_mouse_entered():
	get_parent().get_parent().get_node("PauseMenu").sfx_menu()


func _on_ritual_mouse_entered():
	get_parent().get_parent().get_node("PauseMenu").sfx_menu()


func _on_flame_cut_mouse_entered():
	get_parent().get_parent().get_node("PauseMenu").sfx_menu()
	

func _on_magic_mouse_entered():
	get_parent().get_parent().get_node("PauseMenu").sfx_menu()
	

func _on_health_mouse_entered():
	get_parent().get_parent().get_node("PauseMenu").sfx_menu()

func _on_warrios_might_mouse_entered():
	get_parent().get_parent().get_node("PauseMenu").sfx_menu()

func _on_charge_mouse_entered():
	get_parent().get_parent().get_node("PauseMenu").sfx_menu()

func _on_ethernal_shild_mouse_entered():
	get_parent().get_parent().get_node("PauseMenu").sfx_menu()
