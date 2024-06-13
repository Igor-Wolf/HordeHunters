class_name EnemyShooter

extends Node2D

@export_category("Life")
@export var health: int = 10
@export var death_prefab: PackedScene
var damage_digit_prefab: PackedScene
@onready var damage_digit_marker = $DamageDigitMarker

#Configurando os Drops dos inimigos
@export_category("Drops")
@export var drop_chance: float = 0.1
@export var drop_itens: Array[PackedScene]
@export var drop_chances: Array[float]

@export_category("Atk")
@export var atk_enemy: int 

@export_category("Exp")
@export var experience: float

var damage_cooldown: float = 0.0

@export_category("Projetil")
@onready var vision_area: Area2D = $VisionArea
@export var tnt_bomb : PackedScene
var colldown_tnt= 0.0
@onready var seguir_jogador = $FollowPlayer

func _ready():
	damage_digit_prefab = preload("res://misc/damage_dgt.tscn")

func _process(delta):
	
	damage_cooldown -=delta
	
	if colldown_tnt >0:
		colldown_tnt -= delta
				
	else:
		
		generate_tnt()

func damage_from_enemies(amount: int):
	if damage_cooldown <= 0.0:
		
		damage_cooldown = 0.5
		health -= amount
		
	if health<=0:
		var death_object = death_prefab.instantiate()
		death_object.position = position
		get_parent().add_child(death_object)
		GameManager.enemy_on_screen -= 10
		queue_free()

func damage(amount: int):
	if damage_cooldown <= 0.0:
		
		damage_cooldown = 0.5
		health -= amount
		
		
		#Piscar o inimigo
		modulate = Color("#ffffff75")
		var tween = create_tween()
		tween.set_ease(Tween.EASE_IN)
		tween.set_trans(Tween.TRANS_QUINT)
		tween.tween_property(self, "modulate", Color.WHITE, 0.3)
		
		# Criar texto de dano damage dgt

		var damage_digit = damage_digit_prefab.instantiate()
		damage_digit.value = amount
		if damage_digit_marker:
			
			damage_digit.global_position = damage_digit_marker.global_position
		else:
			damage_digit.global_position = global_position
		get_parent().add_child(damage_digit)
			
			
		#Processar Morte
		if health <= 0:
			die()
func knockback(knockback_strength: int):
	var direction = (GameManager.player.position - position).normalized()
	var knockback_position = position - direction * knockback_strength
	var tween = create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_QUINT)
	tween.tween_property(self, "position", knockback_position, .5)
	
func die():	
	
	# Drop
	if randf() <= drop_chance:
		drop_item()
	elif death_prefab:
		var death_object = death_prefab.instantiate()
		death_object.position = position
		get_parent().add_child(death_object)
					
	# Incrementar contador
	GameManager.monsters_defeated_counter += 1
	
	#Incrementar experiencia
	GameManager.curent_experience += experience
	
	GameManager.enemy_on_screen -= 10
	queue_free()
		
func drop_item():
	var drop = get_random_drop_item().instantiate()
	drop.position = position
	get_parent().add_child(drop)
		
func get_random_drop_item():
	# Listas com 1 item
	if drop_itens.size() ==1:
		return drop_itens[0]	
	
	# Calcular chance maxima
	var max_chance: float = 0.0
	for drop_chance in drop_chances:
		max_chance += drop_chance
		
	#jogar dado
	var radom_value = randf() * max_chance
	
	# girar a roleta
	var needle: float = 0.0
	for i in drop_itens.size():
		var drop_item = drop_itens[i]
		var drop_chance = drop_chances[i] if i< drop_chances.size() else 1
		if radom_value <= drop_chance + needle:
			return drop_item	
		
		needle += drop_chance
	return drop_itens[0]
	
func generate_tnt():
	
	var bodies = vision_area.get_overlapping_bodies()
	
	for body in bodies:		
		if body.is_in_group("player"):
			colldown_tnt = 3			
			
			var bomb = tnt_bomb.instantiate()
			bomb.position = position			
			get_parent().add_child(bomb)			
			
