class_name Player
extends CharacterBody2D

@export var class_char: String = "KNIGHT"

@export_category("Movement")
@export var speed: float = 3

@export_category("Sword")
@export var sword_damage: int = 2

@export_category("Armor")
@export var armor : int = 3 

@export_category("Magic")
@export var magic: int = 0


@export_category("Ritual")
@export var ritual_damage: int = 2
@export var ritual_interval: float = 30
@export var ritual_scene: PackedScene

@export_category("FlameSword")
@export var flame_damage: int = 2
@export var flame_interval: float = 0.0
@export var flame_scene: PackedScene

@export_category("WarriorsMight")
@export var knockback: int = 20

@export_category("Dash")
@export var dash_scene: PackedScene
@export var dash_distance: float = 200.0
@export var dash_speed: float = 400.0
@export var dash_duration: float = 0.1
@export var dash_counter: float = 0.0
@export var dash_damage: int = 2
var is_dashing = true

@export_category("Ethernal Shild")
@export var shild_scene: Array[PackedScene]
@export var shild_damage: int = 1
var shild_active = false
var shild_counter = 0.0


@export_category("Life")
@export var health: int = 100
@export var max_health: int = 100
@export var death_prefab: PackedScene

@onready var sprite: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sword_area: Area2D = $SwordArea
@onready var hitbox_area: Area2D = $HitboxArea
@onready var health_progress_bar: ProgressBar = $HealthProgressBar

@onready var bgm_audio
@onready var sfx_audio = %Sfx
@export_category("Audio")
@export var sfx_list: Array = [preload("res://addons/Audio/sfx/Sword Attack 1.ogg"),
								preload("res://addons/Audio/sfx/Sword Impact Hit 1.ogg"),
								preload("res://addons/Audio/sfx/back_style_1_echo_007.ogg"),
								preload("res://addons/Audio/sfx/error_style_5_001.ogg"),
								preload("res://addons/Audio/sfx/error_style_5_002.ogg"),
								preload("res://addons/Audio/sfx/Fireball 2.ogg")]
								

var is_running: bool = false
var is_attacking: bool = false
var was_running: bool = false
var attack_cooldown: float = 0.0
var attack_direction = [0, 0, 0]
var input_direction = Vector2()
var input_vector = Vector2()
var last_input = ""
var hitbox_cooldown: float = 0.0
var ritual_cooldown: float = 0.0

signal meat_collected(value:int)
signal gold_collected(value:int)

func _ready():
	GameManager.player = self
	meat_collected.connect(func(value:int): 
		GameManager.meat_counter += 1
		GameManager.meat_counter_total += 1
		sfx_audio.stream = sfx_list[3]
		sfx_audio.play())		
	
	gold_collected.connect(func(value:int): 
		GameManager.gold_counter += 1
		sfx_audio.stream = sfx_list[2]
		sfx_audio.play())	
	
	#Tratar o volume
	GameManager.connect("bgm_volume_changed", Callable(self, "_update_bgm_volume"))
	GameManager.connect("sfx_volume_changed", Callable(self, "_update_sfx_volume"))

# Set initial volume
	#_update_bgm_volume(GameManager.bgm_volume)
	_update_sfx_volume(GameManager.sfx_volume)
	
	GameManager.level_up.connect(update_ritual)
	#ritual.damage_amount = ritual_damage + magic	
	

func _process(delta):	
	flame_interval -=delta
	dash_counter -= delta
	shild_counter -= delta
	
	GameManager.player_position = position
	read_input()
	
	# Atualizar o temporizador do ataque
	if is_attacking:
		attack_cooldown -= delta
		if attack_cooldown <= 0:
			is_attacking = false
			is_running = false
			animation_player.play("idle")
			
	if not is_attacking:
		if was_running != is_running:
			if is_running:
				animation_player.play("run")
			else:
				animation_player.play("idle")
	
	# Girar sprite
		if input_vector.x > 0:
			sprite.flip_h = false
		elif input_vector.x < 0:
			sprite.flip_h = true

		# Atualizar last_input com base na última direção de movimento
		if input_vector.y < 0:
			last_input = "up"
		elif input_vector.y > 0:
			last_input = "down"
		elif input_vector.x != 0:
			last_input = "side"

	# Ataque
	if Input.is_action_just_pressed("attack"):
		attack()
	
	# Processar dano	
	update_hitbox_detection(delta)	
	
	# Atualizar a vida do jogador
	health_progress_bar.max_value = max_health
	health_progress_bar.value = health
	
	if dash_counter <= 0 and GameManager.power_ups[8] > 0:
		get_node("PowerUpIndicator").show()
		is_dashing = false
	
	update_shild()

func _physics_process(delta: float):	
	# Modificar a velocidade
	var target_velocity = input_vector * speed * 100
	if is_attacking:
		target_velocity *= 0.1
	velocity = lerp(velocity, target_velocity, 0.1)
	move_and_slide()

	# Atualizar o is_running
	was_running = is_running
	is_running = not input_vector.is_zero_approx()

#--------------------------------------------------------------------- Skills

func update_ritual():
	if GameManager.power_ups[5] > 0 and GameManager.shop_power_ups_p1[0]==1:
		health = max_health
		# Criar o ritual
		var ritual = ritual_scene.instantiate()
		ritual.damage_amount = ritual_damage + magic
		add_child(ritual)
	
func update_flame(direction, rotation_flame):
	if GameManager.power_ups[6] > 0 and flame_interval<=0 and GameManager.shop_power_ups_p1[1]==1:
		# Criar flame
		flame_interval = 2.0
		var flame = flame_scene.instantiate()
		flame.damage_amount = flame_damage + magic
		flame.position = position
		flame.rotation_degrees += rotation_flame
		flame.set_direction(direction)
		get_parent().add_child(flame)
	
func update_knockback (body):
	
	if GameManager.power_ups[7]>0:
		body.knockback(knockback)


func start_dash(direction):
	if is_dashing:
		return
	is_dashing = true
	var dash_vector = direction * dash_distance
	var tween: Tween = create_tween()
	var dash = dash_scene.instantiate()
	dash.damage_amount = dash_damage + ceil(sword_damage/2)
	#Configure o Tween para interpolar a posição do player ao longo do tempo
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_QUINT)
	tween.tween_property(self, "position", position + dash_vector, dash_duration)
	sfx_audio.stream = sfx_list[5]
	sfx_audio.play()	
	add_child(dash)
	Input.start_joy_vibration(0, 0.5, 0.5, 0.5)
	vibration()
	dash_counter = 5.0
	get_node("PowerUpIndicator").hide()
	
func update_shild():
	if shild_counter <=0  and shild_active== false and GameManager.power_ups[9]>0:
		shild_active = true
		
		if GameManager.power_ups[9]==1:
			var shild = shild_scene[0].instantiate()
			shild.damage_amount = shild_damage + ceil(armor/2)
			add_child(shild)
		elif GameManager.power_ups[9]==2:
			var shild = shild_scene[1].instantiate()
			shild.damage_amount = shild_damage + ceil(armor/2)
			add_child(shild)
		elif GameManager.power_ups[9]==3:
			var shild = shild_scene[2].instantiate()
			shild.damage_amount = shild_damage + ceil(armor/2)
			add_child(shild)
		elif GameManager.power_ups[9]>=4:
			var shild = shild_scene[3].instantiate()
			shild.damage_amount = shild_damage + ceil(armor/2)
			add_child(shild)
		shild_counter = 5.5
		shild_active = false
	
	
	
#------------------------------------------------------------ Input


func read_input():
	# Obter o input vector
	input_vector = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	input_direction = input_vector
	# Apagar deadzone do input vector
	var deadzone = 0.15

	if abs(input_vector.x) < deadzone:
		input_vector.x = 0.0
	if abs(input_vector.y) < deadzone:
		input_vector.y = 0.0
		
		
	if Input.is_action_just_pressed("dash") and not is_dashing:
		start_dash(input_vector)

func attack():
	var direction: Vector2
	var rotation_flame =0
	if is_attacking:
		return

	# Definir direção dos ataques
	if input_direction.y < -0.7 or (input_direction.is_zero_approx() and last_input == "up"):
		
		# attack_up1
		# attack_up2
		if attack_direction[1] == 0:
			animation_player.play("attack_up1")
			attack_direction[1] = 1
		else:
			animation_player.play("attack_up2")
			attack_direction[1] = 0
		direction= Vector2.UP
		rotation_flame = 180
		update_flame(direction, rotation_flame)

	elif input_direction.y > 0.7 or (input_direction.is_zero_approx() and last_input == "down"):
		
		# attack_down1
		# attack_down2
		if attack_direction[2] == 0:
			animation_player.play("attack_down1")
			attack_direction[2] = 1
		else:
			animation_player.play("attack_down2")
			attack_direction[2] = 0
		direction= Vector2.DOWN
		rotation_flame = 0
		update_flame(direction, rotation_flame)

	else:
		
		# attack_side1
		# attack_side2
		if attack_direction[0] == 0:
			animation_player.play("attack_side1")
			attack_direction[0] = 1
		else:
			animation_player.play("attack_side2")
			attack_direction[0] = 0
		if sprite.flip_h:
			direction= Vector2.LEFT
			rotation_flame = 90
			update_flame(direction, rotation_flame)
		else:
			direction= Vector2.RIGHT
			rotation_flame = 270
			update_flame(direction, rotation_flame)

	# Configurar temporizador
	attack_cooldown = 0.6
	is_attacking = true	
	
func deal_damage_to_enemies():
	
	var bodies = sword_area.get_overlapping_bodies()
	
	for body in bodies:		
		if body.is_in_group("enemies"):
			
			var enemy = body
			var direction_to_enemy = (enemy.position - position).normalized() 
			var attack_direction_product: Vector2
			
			if last_input== "up":
				attack_direction_product = Vector2.UP
				
			elif last_input== "down":
				attack_direction_product = Vector2.DOWN
				
			elif last_input == "side":
				if sprite.flip_h:
					attack_direction_product = Vector2.LEFT
					
				else:
					attack_direction_product = Vector2.RIGHT
					
			
			var dot_product = direction_to_enemy.dot(attack_direction_product)
			
			
			if dot_product >= 0.50:
				
				enemy.damage(sword_damage)
				update_knockback(body)# empurrão
				sfx_audio.stream = sfx_list[1]
				sfx_audio.play()
		
		else:
			sfx_audio.stream = sfx_list[0]
			sfx_audio.play()
		
				
func damage(amount: int):
	var auxi = 0
	
	if health <= 0:
		return
	
	auxi = amount - armor
	
	if auxi <= 0:
		health -= 1
	else:
		health -= auxi
	
	
	Input.start_joy_vibration(0, 0.5, 0.5, 0.5)
	vibration()
	
	
	
	
	#Piscar o jogador
	modulate = Color("#ffffff75")
	var tween = create_tween()
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_QUINT)
	tween.tween_property(self, "modulate", Color.WHITE, 0.3)
	#Processar Morte
	if health <= 0:
		get_parent().get_node("StatisticsUi").queue_free()
		die()
		
func update_hitbox_detection(delta):
	#Temporizador
	hitbox_cooldown-=delta
	if hitbox_cooldown >= 0: 
		return
	# Frequencia (2x por segundo)
	hitbox_cooldown =0.5
	
	# HitboxArea
	var bodies = hitbox_area.get_overlapping_bodies()
	
	for body in bodies:
		if body.is_in_group("enemies"):
			var enemy = body
			var damage_amount = enemy.atk_enemy
			damage(damage_amount)
	
func die():
	AchievementsManager.player_died = true
	GameManager.end_game()
	
	if death_prefab:
		var death_object = death_prefab.instantiate()
		death_object.position = position
		get_parent().add_child(death_object)
	
		
	queue_free()
	
	
func heal(amount: int):
	health += amount
	if health > max_health:
		health = max_health

	return health

#-------------------------------------------------- Alterar o volume

#func _update_bgm_volume(value):
	#bgm_audio.volume_db = linear_to_db(value)

func _update_sfx_volume(value):
	sfx_audio.volume_db = linear_to_db(value)

func linear_to_db(value):
	return 20 * log(value) / log(10)

#vibration web
	
func vibration():
	var js_code = """
			(function vibrateGamepad() {
				var gamepad = navigator.getGamepads()[0];
				if (gamepad && gamepad.vibrationActuator) {
					gamepad.vibrationActuator.playEffect("dual-rumble", {
						duration: 500,
						startDelay: 0,
						strongMagnitude: 0.5,
						weakMagnitude: 0.5
					});
				} else {
					console.log("Gamepad vibration not supported or not connected");
				}
			})();
			"""
	JavaScriptBridge.eval(js_code, true)
