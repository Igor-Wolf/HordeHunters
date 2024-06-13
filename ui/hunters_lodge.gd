extends CanvasLayer

var button_focused
@onready var stats_label = $Main/StatsPanel/StatsLabel
@onready var main_label = $Main/PanelLabel/MainLabel

@onready var last_click_time = 0.0

@onready var scroll_container: ScrollContainer = $Main/PanelLabel

@onready var gold_label = %GoldLabel

func _process(delta):
	
	# Comprar habilidades
	
	if GameManager.shop_power_ups_p1[0] != 0:
		$Main/ContainerSkills2/Button6/Panel2.hide()
	if GameManager.shop_power_ups_p1[1] != 0:
		$Main/ContainerSkills2/Button7/Panel2.hide()
	if GameManager.shop_power_ups_p1[2] != 0:
		$Main/ContainerSkills2/Button8/Panel2.hide()
	if GameManager.shop_power_ups_p1[3] != 0:
		$Main/ContainerSkills2/Button9/Panel2.hide()
	if GameManager.shop_power_ups_p1[4] != 0:
		$Main/ContainerSkills2/Button10/Panel2.hide()	
	
	
	gold_label.text = str(GameManager.gold_counter)	
	
	button_focused = get_viewport().gui_get_focus_owner()		
	if !button_focused:		
		if Input.is_joy_known(0):
			$Main/ContainerPlayer/PButton.grab_focus()
			
			
	last_click_time -= delta
	if last_click_time < 0:
		last_click_time = 0
#
	if Input.is_action_just_pressed("confirm_button") or Input.is_action_just_pressed("ui_accept") or Input.is_mouse_button_pressed(0):
		if last_click_time <= 0:
			_on_confirm_button()
	
	
	if Input.is_action_just_pressed("scroll_up"):
		scroll_container.scroll_vertical = scroll_container.get_v_scroll_bar().value -50
		
	if Input.is_action_just_pressed("scroll_down"):
		scroll_container.scroll_vertical = scroll_container.get_v_scroll_bar().value +50
		

# ------------------------------------------------------------------- confirmação dos botões

func _on_confirm_button():
	var focused_button = get_viewport().gui_get_focus_owner()
	if focused_button == $Main/Hunt:
		_on_hunt_pressed()
	elif focused_button == $Main/Return:
		_on_return_pressed()
		
	elif focused_button == $Main/ContainerPlayer/PButton:
		_on_p_button_pressed()
	elif focused_button == $Main/ContainerPlayer/PButton2:
		_on_p_button_2_pressed()
	elif focused_button == $Main/ContainerPlayer/PButton3:
		_on_p_button_3_pressed()
	elif focused_button == $Main/ContainerPlayer/PButton4:
		_on_p_button_4_pressed()
	elif focused_button == $Main/ContainerPlayer/PButton5:
		_on_p_button_5_pressed()
	elif focused_button == $Main/ContainerPlayer/PButton6:
		_on_p_button_6_pressed()
		
	elif focused_button == $Main/ContainerStage/StButton:
		_on_st_button_pressed()
	elif focused_button == $Main/ContainerStage/StButton2:
		_on_st_button_2_pressed()
	elif focused_button == $Main/ContainerStage/StButton3:
		_on_st_button_3_pressed()
	elif focused_button == $Main/ContainerStage/StButton4:
		_on_st_button_4_pressed()
	elif focused_button == $Main/ContainerStage/StButton5:
		_on_st_button_5_pressed()
	elif focused_button == $Main/ContainerStage/StButton6:
		_on_st_button_6_pressed()
	elif focused_button == $Main/ContainerStage/StButton7:
		_on_st_button_7_pressed()
	elif focused_button == $Main/ContainerStage/StButton8:
		_on_st_button_8_pressed()
	elif focused_button == $Main/ContainerStage/StButton9:
		_on_st_button_9_pressed()
	elif focused_button == $Main/ContainerStage/StButton10:
		_on_st_button_10_pressed()
	
	elif focused_button == $Main/ContainerSkills/SButton:
		_on_s_button_pressed()
	elif focused_button == $Main/ContainerSkills/SButton2:
		_on_s_button_2_pressed()
	elif focused_button == $Main/ContainerSkills/SButton3:
		_on_s_button_3_pressed()
	elif focused_button == $Main/ContainerSkills/SButton4:
		_on_s_button_4_pressed()
	elif focused_button == $Main/ContainerSkills/SButton5:
		_on_s_button_5_pressed()
	elif focused_button == $Main/ContainerSkills/SButton6:
		_on_s_button_6_pressed()
	elif focused_button == $Main/ContainerSkills/SButton7:
		_on_s_button_7_pressed()
	elif focused_button == $Main/ContainerSkills/SButton8:
		_on_s_button_8_pressed()
	elif focused_button == $Main/ContainerSkills/SButton9:
		_on_s_button_9_pressed()
	elif focused_button == $Main/ContainerSkills/SButton10:
		_on_s_button_10_pressed()
		

# ------------------------------------------------------------------- Botões pressionados

func _on_hunt_pressed():
	get_tree().change_scene_to_file("res://level1.tscn")


func _on_return_pressed():
	get_parent().show()
	hide()


func _on_p_button_pressed():
	pass # Replace with function body.


func _on_p_button_2_pressed():
	var content_bg_story = "NOT YET IMPLEMENTED"
		
	main_label.text = content_bg_story


func _on_p_button_3_pressed():
	var content_bg_story = "NOT YET IMPLEMENTED"
	
	main_label.text = content_bg_story


func _on_p_button_4_pressed():
	pass # Replace with function body.


func _on_p_button_5_pressed():
	pass # Replace with function body.


func _on_p_button_6_pressed():
	pass # Replace with function body.


func _on_st_button_pressed():
	pass # Replace with function body.


func _on_st_button_2_pressed():
	pass # Replace with function body.


func _on_st_button_3_pressed():
	pass # Replace with function body.


func _on_st_button_4_pressed():
	pass # Replace with function body.


func _on_st_button_5_pressed():
	pass # Replace with function body.


func _on_st_button_6_pressed():
	pass # Replace with function body.


func _on_st_button_7_pressed():
	pass # Replace with function body.


func _on_st_button_8_pressed():
	pass # Replace with function body.


func _on_st_button_9_pressed():
	pass # Replace with function body.


func _on_st_button_10_pressed():
	pass # Replace with function body.


func _on_s_button_pressed():
	pass # Replace with function body.


func _on_s_button_2_pressed():
	pass # Replace with function body.


func _on_s_button_3_pressed():
	pass # Replace with function body.


func _on_s_button_4_pressed():
	pass # Replace with function body.


func _on_s_button_5_pressed():
	pass # Replace with function body.


func _on_s_button_6_pressed():
	if GameManager.shop_power_ups_p1[0] == 0 and GameManager.gold_counter >=5:
		GameManager.shop_power_ups_p1[0] = 1
		GameManager.gold_counter -= 5
		
	elif GameManager.shop_power_ups_p1[0] == 1:
		pass
	elif GameManager.gold_counter <5:
		$Main/PanelLabel/MainLabel.text = "YOU DO NOT HAVE ENOUGH GOLD."
		
	
func _on_s_button_7_pressed():
	if GameManager.shop_power_ups_p1[1] == 0 and GameManager.gold_counter >=80:
		GameManager.shop_power_ups_p1[1] = 1
		GameManager.gold_counter -= 80
		
	elif GameManager.shop_power_ups_p1[1] == 1:
		pass
	elif GameManager.gold_counter <80:
		$Main/PanelLabel/MainLabel.text = "YOU DO NOT HAVE ENOUGH GOLD."


func _on_s_button_8_pressed():
	if GameManager.shop_power_ups_p1[2] == 0 and GameManager.gold_counter >=100:
		GameManager.shop_power_ups_p1[2] = 1
		GameManager.gold_counter -= 100
		
	elif GameManager.shop_power_ups_p1[2] == 1:
		pass
	elif GameManager.gold_counter <100:
		$Main/PanelLabel/MainLabel.text = "YOU DO NOT HAVE ENOUGH GOLD."


func _on_s_button_9_pressed():
	if GameManager.shop_power_ups_p1[3] == 0 and GameManager.gold_counter >=150:
		GameManager.shop_power_ups_p1[3] = 1
		GameManager.gold_counter -= 150
		
	elif GameManager.shop_power_ups_p1[3] == 1:
		pass
	elif GameManager.gold_counter <150:
		$Main/PanelLabel/MainLabel.text = "YOU DO NOT HAVE ENOUGH GOLD."


func _on_s_button_10_pressed():
	if GameManager.shop_power_ups_p1[4] == 0 and GameManager.gold_counter >=200:
		GameManager.shop_power_ups_p1[4] = 1
		GameManager.gold_counter -= 200
		
	elif GameManager.shop_power_ups_p1[4] == 1:
		pass
	elif GameManager.gold_counter <200:
		$Main/PanelLabel/MainLabel.text = "YOU DO NOT HAVE ENOUGH GOLD."

# ------------------------------------------------------------------- Hover do mouse


func _on_hunt_mouse_entered():
	sfx_play()
	


func _on_return_mouse_entered():
	sfx_play()


func _on_p_button_mouse_entered():
	sfx_play()
	content_player1()


func _on_p_button_2_mouse_entered():
	sfx_play()
	content_player2()


func _on_p_button_3_mouse_entered():
	sfx_play()
	content_player3()


func _on_p_button_4_mouse_entered():
	sfx_play()
	content_player4()


func _on_p_button_5_mouse_entered():
	sfx_play()
	content_player5()


func _on_p_button_6_mouse_entered():
	sfx_play()
	content_player6()


func _on_st_button_mouse_entered():
	sfx_play()
	content_stage1()


func _on_st_button_2_mouse_entered():
	sfx_play()
	content_stage2()


func _on_st_button_3_mouse_entered():
	sfx_play()
	content_stage3()


func _on_st_button_4_mouse_entered():
	sfx_play()
	content_stage4()


func _on_st_button_5_mouse_entered():
	sfx_play()
	content_stage5()


func _on_st_button_6_mouse_entered():
	sfx_play()
	content_stage6()


func _on_st_button_7_mouse_entered():
	sfx_play()
	content_stage7()


func _on_st_button_8_mouse_entered():
	sfx_play()
	content_stage8()


func _on_st_button_9_mouse_entered():
	sfx_play()
	content_stage9()


func _on_st_button_10_mouse_entered():
	sfx_play()
	content_stage10()


func _on_s_button_mouse_entered():
	sfx_play()
	content_skill_p1()


func _on_s_button_2_mouse_entered():
	sfx_play()
	content_skill2_p1()


func _on_s_button_3_mouse_entered():
	sfx_play()
	content_skill3_p1()


func _on_s_button_4_mouse_entered():
	sfx_play()
	content_skill4_p1()


func _on_s_button_5_mouse_entered():
	sfx_play()
	content_skill5_p1()


func _on_s_button_6_mouse_entered():
	sfx_play()
	content_skill6_p1()


func _on_s_button_7_mouse_entered():
	sfx_play()
	content_skill7_p1()


func _on_s_button_8_mouse_entered():
	sfx_play()
	content_skill8_p1()


func _on_s_button_9_mouse_entered():
	sfx_play()
	content_skill9_p1()


func _on_s_button_10_mouse_entered():
	sfx_play()
	content_skill10_p1()

# ------------------------------------------------------------------- Focus do controle


func _on_hunt_focus_entered():
	sfx_play()
	


func _on_return_focus_entered():
	sfx_play()


func _on_p_button_focus_entered():
	sfx_play()
	content_player1()
	

func _on_p_button_2_focus_entered():
	sfx_play()
	content_player2()


func _on_p_button_3_focus_entered():
	sfx_play()
	content_player3()


func _on_p_button_4_focus_entered():
	sfx_play()
	content_player4()


func _on_p_button_5_focus_entered():
	sfx_play()
	content_player5()


func _on_p_button_6_focus_entered():
	sfx_play()
	content_player6()


func _on_st_button_focus_entered():
	sfx_play()
	content_stage1()


func _on_st_button_2_focus_entered():
	sfx_play()
	content_stage2()


func _on_st_button_3_focus_entered():
	sfx_play()
	content_stage3()


func _on_st_button_4_focus_entered():
	sfx_play()
	content_stage4()


func _on_st_button_5_focus_entered():
	sfx_play()
	content_stage5()


func _on_st_button_6_focus_entered():
	sfx_play()
	content_stage6()


func _on_st_button_7_focus_entered():
	sfx_play()
	content_stage7()


func _on_st_button_8_focus_entered():
	sfx_play()
	content_stage8()


func _on_st_button_9_focus_entered():
	sfx_play()
	content_stage9()


func _on_st_button_10_focus_entered():
	sfx_play()
	content_stage10()


func _on_s_button_focus_entered():
	sfx_play()
	content_skill_p1()


func _on_s_button_2_focus_entered():
	sfx_play()
	content_skill2_p1()


func _on_s_button_3_focus_entered():
	sfx_play()
	content_skill3_p1()


func _on_s_button_4_focus_entered():
	sfx_play()
	content_skill4_p1()


func _on_s_button_5_focus_entered():
	sfx_play()
	content_skill5_p1()


func _on_s_button_6_focus_entered():
	sfx_play()
	content_skill6_p1()


func _on_s_button_7_focus_entered():
	sfx_play()
	content_skill7_p1()


func _on_s_button_8_focus_entered():
	sfx_play()
	content_skill8_p1()


func _on_s_button_9_focus_entered():
	sfx_play()
	content_skill9_p1()


func _on_s_button_10_focus_entered():
	sfx_play()
	content_skill10_p1()
	
# ------------------------------------------------------------------- Chamar sfx do main menu

func sfx_play():
	get_parent().sfx_menu()


# ------------------------------------------------------------------- Conteudo das labels

# Players
func content_player1():
	
	var content_stats = "CLASS: KNIGHT\nMAX HEALTH: 100\nSTRENGHT: 2\nSPEED: 3\nARMOR: 3\nMAGIC: 0"
	var content_bg_story = "A FAITHFUL KNIGHT WHO SERVES HIS KING BY DEFEATING HORDES OF ENEMIES."
	
	stats_label.text = content_stats
	main_label.text = content_bg_story
	
func content_player2():
	
	var content_stats = "CLASS: ARCHER\nMAX HEALTH: 90\nSTRENGHT: 2\nSPEED: 4\nARMOR: 2\nMAGIC: 1"
	var content_bg_story = "A SKILLED AND EXPERIENCED ARCHER WHO MAKES A LIVING BY HUNTING HORDES OF ENEMIES TO EARN HIS OWN GOLD.\n\n500 GOLD TO UNLOCK"
	
	stats_label.text = content_stats
	main_label.text = content_bg_story
	
func content_player3():
	
	var content_stats = "CLASS: MAGE\nMAX HEALTH: 100\nSTRENGHT: 1\nSPEED: 3\nARMOR: 1\nMAGIC: 3"
	var content_bg_story = "AN EXILED GOBLIN SHAMAN WHO ROAMS THE LAND EXTERMINATING HORDES OF ENEMIES TO REDEEM HIMSELF.\n\n600 GOLD TO UNLOCK"
	
	stats_label.text = content_stats
	main_label.text = content_bg_story

func content_player4():
	
	var content_stats = "CLASS: \nMAX HEALTH: \nSTRENGHT: \nSPEED: \nARMOR: \nMAGIC: "
	var content_bg_story = "NOT YET IMPLEMENTED"
	
	stats_label.text = content_stats
	main_label.text = content_bg_story

func content_player5():
	
	var content_stats = "CLASS: \nMAX HEALTH: \nSTRENGHT: \nSPEED: \nARMOR: \nMAGIC: "
	var content_bg_story = "NOT YET IMPLEMENTED"
	
	stats_label.text = content_stats
	main_label.text = content_bg_story
	
func content_player6():
	
	var content_stats = "CLASS: \nMAX HEALTH: \nSTRENGHT: \nSPEED: \nARMOR: \nMAGIC: "
	var content_bg_story = "NOT YET IMPLEMENTED"
	
	stats_label.text = content_stats
	main_label.text = content_bg_story
	
	
	
# Skills and attributes
func content_skill_p1():
	
	var content_stats = "CLASS: \nMAX HEALTH: \nSTRENGHT: \nSPEED: \nARMOR: \nMAGIC: "
	var content_bg_story = "STRENGTH ATTRIBUTE\n\nVALUE DESIGNATED FOR THE PHYSICAL DAMAGE GENERATED BY THE CHARACTER. IT CAN BE PURE OR DERIVED FROM A BONUS."
	
	stats_label.text = content_stats
	main_label.text = content_bg_story

func content_skill2_p1():
	
	var content_stats = "CLASS: \nMAX HEALTH: \nSTRENGHT: \nSPEED: \nARMOR: \nMAGIC: "
	var content_bg_story = "HEALTH ATTRIBUTE\n\nVALUE DESIGNATED FOR THE CHARACTER'S MAXIMUM HEALTH AND LIFE."
	
	stats_label.text = content_stats
	main_label.text = content_bg_story
	
func content_skill3_p1():
	
	var content_stats = "CLASS: \nMAX HEALTH: \nSTRENGHT: \nSPEED: \nARMOR: \nMAGIC: "
	var content_bg_story = "ARMOR ATTRIBUTE\n\nVALUE DESIGNATED FOR REDUCING DAMAGE RECEIVED BY THE ENEMY BEFORE IT AFFECTS HEALTH."
	
	stats_label.text = content_stats
	main_label.text = content_bg_story
	
func content_skill4_p1():
	
	var content_stats = "CLASS: \nMAX HEALTH: \nSTRENGHT: \nSPEED: \nARMOR: \nMAGIC: "
	var content_bg_story = "SPEED ATTRIBUTE\n\nVALUE DESIGNATED FOR THE CHARACTER'S MOVEMENT SPEED."
	
	stats_label.text = content_stats
	main_label.text = content_bg_story
	
func content_skill5_p1():
	
	var content_stats = "CLASS: \nMAX HEALTH: \nSTRENGHT: \nSPEED: \nARMOR: \nMAGIC: "
	var content_bg_story = "MAGIC ATTRIBUTE\n\nVALUE DESIGNATED FOR THE MAGICAL DAMAGE GENERATED BY THE CHARACTER. IT CAN BE PURE OR DERIVED FROM A BONUS."
	
	stats_label.text = content_stats
	main_label.text = content_bg_story

func content_skill6_p1():
	
	var content_stats = "CLASS: \nMAX HEALTH: \nSTRENGHT: \nSPEED: \nARMOR: \nMAGIC: "
	var content_bg_story = "RITUAL SKILL\n\nGRANTS MAGICAL DAMAGE IN AREA CAUSED BY THE GRACE OF THE GODS WHEN LEVELING UP. \n\n5 GOLD TO UNLOCK"
	
	stats_label.text = content_stats
	main_label.text = content_bg_story
	
func content_skill7_p1():
	
	var content_stats = "CLASS: \nMAX HEALTH: \nSTRENGHT: \nSPEED: \nARMOR: \nMAGIC: "
	var content_bg_story = "FLAMING CUT SKILL\n\nTHE FRICTION OF THE BLADE CUTTING THROUGH THE AIR GENERATES MAGICAL HEAT DERIVED FROM THE SPIRITS OF FLAMES, DEALING MAGICAL DAMAGE IN LINE TO ENEMIES. HAS A COOLDOWN OF 2.0s.\n\n80 GOLD TO UNLOCK"
	
	stats_label.text = content_stats
	main_label.text = content_bg_story
	
func content_skill8_p1():
	
	var content_stats = "CLASS: \nMAX HEALTH: \nSTRENGHT: \nSPEED: \nARMOR: \nMAGIC: "
	var content_bg_story = "WARRIOR'S MIGHT SKILL\n\nYEARS OF TRAINING HAVE GRANTED THE WARRIOR SUPERHUMAN STRENGTH. NORMAL ATTACKS CAN PUSH ENEMIES AWAY. \n\n100 GOLD TO UNLOCK."
	
	stats_label.text = content_stats
	main_label.text = content_bg_story
	
func content_skill9_p1():
	
	var content_stats = "CLASS: \nMAX HEALTH: \nSTRENGHT: \nSPEED: \nARMOR: \nMAGIC: "
	var content_bg_story = "CHARGE SKILL\n\nA FEARLESS ADVANCE TOWARDS THE ENEMY, DEALING DAMAGE AND PUSHING ANYONE IN THE WAY. THE LAST SPRINT. \n\n150 GOLD TO UNLOCK."
	
	stats_label.text = content_stats
	main_label.text = content_bg_story

func content_skill10_p1():
	
	var content_stats = "CLASS: \nMAX HEALTH: \nSTRENGHT: \nSPEED: \nARMOR: \nMAGIC: "
	var content_bg_story = "ETERNAL SHIELD SKILL\n\nTHE BEST DEFENSE IS A GOOD OFFENSE. IMPRESSED BY HIS DEEDS, THE DEITIES GRANT THE WARRIOR PROTECTION. CREATES A SHIELD PER LEVEL THAT DEALS DAMAGE TO ANYONE WITHIN RANGE.\n\n200 GOLD TO UNLOCK"
	
	stats_label.text = content_stats
	main_label.text = content_bg_story
	
	
# Stages


func content_stage1():
	
	var content_stats = "CLASS: \nMAX HEALTH: \nSTRENGHT: \nSPEED: \nARMOR: \nMAGIC: "
	var content_bg_story = "RIVER PASSAGE\n\nFORMER ROYAL FIELDS NOW INFESTED WITH GOBLINS AND KILLER SHEEP. CULTISTS ROAM THE AREA SEEKING VICTIMS FOR SACRIFICE."
	
	stats_label.text = content_stats
	main_label.text = content_bg_story
	
func content_stage2():
	
	var content_stats = "CLASS: \nMAX HEALTH: \nSTRENGHT: \nSPEED: \nARMOR: \nMAGIC: "
	var content_bg_story = "NOT YET IMPLEMENTED"
	
	stats_label.text = content_stats
	main_label.text = content_bg_story
func content_stage3():
	
	var content_stats = "CLASS: \nMAX HEALTH: \nSTRENGHT: \nSPEED: \nARMOR: \nMAGIC: "
	var content_bg_story = "NOT YET IMPLEMENTED"
	
	stats_label.text = content_stats
	main_label.text = content_bg_story
func content_stage4():
	
	var content_stats = "CLASS: \nMAX HEALTH: \nSTRENGHT: \nSPEED: \nARMOR: \nMAGIC: "
	var content_bg_story = "NOT YET IMPLEMENTED"
	
	stats_label.text = content_stats
	main_label.text = content_bg_story
func content_stage5():
	
	var content_stats = "CLASS: \nMAX HEALTH: \nSTRENGHT: \nSPEED: \nARMOR: \nMAGIC: "
	var content_bg_story = "NOT YET IMPLEMENTED"
	
	stats_label.text = content_stats
	main_label.text = content_bg_story
func content_stage6():
	
	var content_stats = "CLASS: \nMAX HEALTH: \nSTRENGHT: \nSPEED: \nARMOR: \nMAGIC: "
	var content_bg_story = "NOT YET IMPLEMENTED"
	
	stats_label.text = content_stats
	main_label.text = content_bg_story
func content_stage7():
	
	var content_stats = "CLASS: \nMAX HEALTH: \nSTRENGHT: \nSPEED: \nARMOR: \nMAGIC: "
	var content_bg_story = "NOT YET IMPLEMENTED"
	
	stats_label.text = content_stats
	main_label.text = content_bg_story
func content_stage8():
	
	var content_stats = "CLASS: \nMAX HEALTH: \nSTRENGHT: \nSPEED: \nARMOR: \nMAGIC: "
	var content_bg_story = "NOT YET IMPLEMENTED"
	
	stats_label.text = content_stats
	main_label.text = content_bg_story
func content_stage9():
	
	var content_stats = "CLASS: \nMAX HEALTH: \nSTRENGHT: \nSPEED: \nARMOR: \nMAGIC: "
	var content_bg_story = "NOT YET IMPLEMENTED"
	
	stats_label.text = content_stats
	main_label.text = content_bg_story
func content_stage10():
	
	var content_stats = "CLASS: \nMAX HEALTH: \nSTRENGHT: \nSPEED: \nARMOR: \nMAGIC: "
	var content_bg_story = "NOT YET IMPLEMENTED"
	
	stats_label.text = content_stats
	main_label.text = content_bg_story
	

