extends Node

signal game_over
var player_position: Vector2
var player: Player
var is_game_over: bool = false

var time_elapsed: float = 0.0
var minutes : int
var time_elapsed_string: String
var meat_counter: int = 0
var meat_counter_total: int = 0
var gold_counter: int = 0
var monsters_defeated_counter: int = 0
var monsters_restriction: int = 0

# Variáveis para os volumes
var bgm_volume: float = .5
var sfx_volume: float = .5


var curent_experience : float = 0
var next_level : float = 200
var last_level : float = 0
var current_level : int = 1


var power_ups: Array = [0,0,0,0,0,0,0,0,0,0]
#Força
#Health
#Armor
#Speed
#Magic
#Ritual
#Flame Cut
#Warrior's Might
#Charge
#Ethernal Shild

var shop_power_ups_p1: Array = [0,0,0,0,0]


var problematic = false
var problematic_count = 0.0
var menu_open = false
var menu_count : float= 0.0


var enemy_on_screen = 0


func _process(delta):
	
	time_elapsed += delta
	menu_count -= delta
	
	if menu_count <=0:
		menu_open = false
		
	
	# Atualizar o temporizador
	var time_elapsed_in_seconds: int = int(time_elapsed)
	var seconds: int = time_elapsed_in_seconds % 60
	minutes= time_elapsed_in_seconds / 60
	
	# Formatar e atualizar o texto do timer_label
	time_elapsed_string = "%02d:%02d" % [minutes, seconds]
	
	# Verificar se subiu de nível:
	if curent_experience >= next_level:
		get_next_level()

func end_game():
	
	if is_game_over:return
	is_game_over = true
	game_over.emit()
	menu_open = true


func reset():
	player = null
	player_position = Vector2.ZERO
	is_game_over = false	
	time_elapsed = 0.0
	time_elapsed_string = "00:00"
	meat_counter = 0
	monsters_defeated_counter = 0
	current_level = 1
	curent_experience = 0
	next_level = 200
	last_level = 0
	power_ups.fill(0)
	enemy_on_screen = 0

	for connection in game_over.get_connections():
		game_over.disconnect(connection.callable)
		
		
#------------------------------------------------------- Subir de nível
func get_next_level():
	menu_open = true
	current_level += 1
	last_level = next_level
	next_level = ceil(next_level*1.7)
	emit_signal("level_up")

signal level_up
#------------------------------------------------------- Configurar volume

func set_bgm_volume(value:float):
	bgm_volume = value
	#Emitir o sinal  para atualizar o volume do BGM
	emit_signal("bgm_volume_changed", value)
	
func set_sfx_volume(value:float):
	sfx_volume = value
	#Emitir o sinal  para atualizar o volume do BGM
	emit_signal("sfx_volume_changed", value)
	
# Sinais emitidos
signal bgm_volume_changed(value)
signal sfx_volume_changed(value)

#------------------------------------------------------- Função de Musica nos menus
	
func close_menu():
	menu_count = 0.1
	problematic_count = 0.1


