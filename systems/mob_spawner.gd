class_name MobSpawner
extends Node2D

@export var creatures: Array[PackedScene]
@export var creatures2: Array[PackedScene]
var mobs_per_minute: float = 60.0

@onready var path_follow_2d: PathFollow2D = %PathFollow2D
var cooldown: float = 0.0

func _process(delta):
	#Ignorar Game Over
	if GameManager.is_game_over: return
	
	# Temporizador: cooldown	
	cooldown -= delta
	if cooldown >0: return
		
	# Frequencia: Monstros por minuto	
	# intervalo em segundo entre monstros => 60(segundos em um minuto) / frequencia escolhida	
	var interval = 60.0 / mobs_per_minute
	cooldown = interval
	
	#Checar se o ponto é valido
	var point = get_point()
	var world_state = get_world_2d().direct_space_state
	var parameters = PhysicsPointQueryParameters2D.new()
	parameters.position = point
	#parameters.collision_mask = 0b1001 sobre camadas diferentes de colisão
	var result: Array = world_state.intersect_point(parameters, 1)
	if not result.is_empty(): return
	
	if GameManager.minutes <8:
		# Instaciar uma criatura aleatoria
		var index = randi_range(0, creatures.size()-1)	
		var creature_scene = creatures[index]
		var creature = creature_scene.instantiate()
		creature.global_position = point
		if GameManager.enemy_on_screen <= 410:
			get_parent().add_child(creature)
			GameManager.enemy_on_screen += 1 	
			
	elif GameManager.minutes >=8 and GameManager.minutes <9:
		# Instaciar uma criatura aleatoria
		var index = randi_range(0, creatures2.size()-1)	
		var creature_scene = creatures2[index]
		var creature = creature_scene.instantiate()
		creature.global_position = point
		if GameManager.enemy_on_screen <= 410:
			get_parent().add_child(creature)
			if creatures2[index] == creatures2[2]:
				GameManager.enemy_on_screen +=10
			else:
				GameManager.enemy_on_screen += 1 
	elif GameManager.minutes >=9:
		# Instaciar uma criatura aleatoria
		var index = randi_range(0, creatures.size()-1)	
		var creature_scene = creatures[index]
		var creature = creature_scene.instantiate()
		creature.global_position = point
		if GameManager.enemy_on_screen <= 410:
			get_parent().add_child(creature)
			GameManager.enemy_on_screen += 1 
			

func get_point(): 
	path_follow_2d.progress_ratio = randf() #Randon Float
	return path_follow_2d.global_position
	
