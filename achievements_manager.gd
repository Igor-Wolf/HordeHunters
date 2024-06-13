extends Node

# Variável para armazenar achievements desbloqueados
var achievments_path: Array = ["res://achievements_scenes/achievement_01.tscn",
"res://achievements_scenes/achievement_02.tscn",
"res://achievements_scenes/achievement_03.tscn",
"res://achievements_scenes/achievement_04.tscn",
"res://achievements_scenes/achievement_05.tscn",
"res://achievements_scenes/achievement_06.tscn",
"res://achievements_scenes/achievement_07.tscn"]

var achievements_unlocked = [0,0,0,0,0,0,0]

# kiled first enemy
# died first time
# shopping first time
# survived 15 min
# shopping all skills from a character
# ate 200 meat
# killed the first boss


var player_died= false
var boses_killed= [0]


func _process(delta):
	conquist_check()
	

# Instanciar uma nova cena
func instantiate_scene(scene_path: String, number):
	
	var scene = load(scene_path).instantiate()
	
	if number == 2 or number==4:
		get_tree().root.get_node("MainMenu").add_child(scene)
		scene.owner = get_tree().root.get_node("MainMenu")
	else:	
		get_tree().root.add_child(scene)
		scene.owner = get_tree().root
	


#------------------------------------------------------  Checar conquista


func conquist_check():
	# kiled first enemy
	if GameManager.monsters_defeated_counter > 0 and achievements_unlocked[0] == 0:
		achievements_unlocked[0] = 1
		instantiate_scene(achievments_path[0], 0)
	
	# died first time
	if player_died  and achievements_unlocked[1] == 0:		
		achievements_unlocked[1] = 1
		instantiate_scene(achievments_path[1], 1)
	
	# shopping first time
	if GameManager.shop_power_ups_p1 != [0,0,0,0,0] and achievements_unlocked[2]== 0 :
		achievements_unlocked[2] = 1
		instantiate_scene(achievments_path[2], 2) 
		
	#survived 15 min
	if GameManager.minutes >=15 and achievements_unlocked[3]== 0:
		achievements_unlocked[3] = 1
		instantiate_scene(achievments_path[3], 3) 
	
	# shopping all skills from a character
	if GameManager.shop_power_ups_p1 == [1,1,1,1,1] and achievements_unlocked[4]== 0 :
		achievements_unlocked[4] = 1
		instantiate_scene(achievments_path[4], 4) 
	
	# ate 200 meat
	if GameManager.meat_counter_total >=200 and achievements_unlocked[5]== 0:
		achievements_unlocked[5] = 1
		instantiate_scene(achievments_path[5], 5) 
	
	# killed the first boss	
	if boses_killed[0]!=0  and achievements_unlocked[6] == 0:		
		achievements_unlocked[6] = 1
		instantiate_scene(achievments_path[6], 6)
