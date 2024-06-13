extends Node2D


@export_category("Damage")
@export var damage : int


@export var speed = 300.0  # Ajuste a velocidade conforme necessário
@onready var marker = $BombMarker
var input_vector = Vector2.ZERO  # Vetor de movimento do projétil
var target_position = Vector2.ZERO  # Posição de destino do projétil
@onready var dynamyte_sprite = $Sprite2D
@onready var explosion_sprite = $Explosion
@onready var animation_player = $ExplosionAnimation
@onready var bomb_area = $Area2D

@onready var explosion_count = 1.2

func _ready():
	# Definir a posição do marcador para a posição do jogador ao criar o projétil
	target_position = GameManager.player_position

	# Calcular o vetor de direção para o projétil
	var difference = target_position - global_position
	input_vector = difference.normalized()

func _process(delta):
	
	
	explosion_count-=delta
	marker.global_position = target_position
	# Ignorar Game Over
	if GameManager.is_game_over:
		return
	
	# Verificar a distância entre o projétil e o marcador
	if global_position.distance_to(target_position) > speed * delta:
		# Mover projétil na direção do marcador
		global_position += input_vector * speed * delta
	else:
		# Posicionar o projétil exatamente no marcador e parar o movimento
		global_position = target_position
		explosion()
		
		
func deal_damage_explosion():		
	var bodies = bomb_area.get_overlapping_bodies()
	for body in bodies:		
			if body.is_in_group("enemies"):
				body.damage_from_enemies(damage)
			elif body.is_in_group("player"):
				body.damage(damage)		
		
		
		
		
#------------------------------------------------------ Processamento visual		
		
func explosion():
	
	if explosion_count <=0:
		marker.hide()
		dynamyte_sprite.hide()
		explosion_sprite.show()
		animation_player.play("default")
	
	
func end_explosion():
	queue_free()
