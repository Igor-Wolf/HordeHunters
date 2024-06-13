extends Node2D

@export var game_ui: CanvasLayer
@export var game_over_ui_template: PackedScene
#@export var pause_template: PackedScene


@export var boss : PackedScene
var is_boss_on_screen = false


var pause_instance: Node = null
var game_over_instance: Node = null

@onready var bgm_audio = $Audio/AudioStreamPlayer2D
@onready var sfx_audio

func _ready():
	GameManager.time_elapsed = 0.0
	#Tratar o volume
	GameManager.connect("bgm_volume_changed", Callable(self, "_update_bgm_volume"))
	GameManager.connect("sfx_volume_changed", Callable(self, "_update_sfx_volume"))

# Set initial volume
	_update_bgm_volume(GameManager.bgm_volume)
	#_update_sfx_volume(GameManager.sfx_volume)
	
	GameManager.game_over.connect(trigger_game_over)
	get_tree().paused = false

func _process(delta):
	if Input.is_action_just_pressed("start_button"):
		toggle_pause()
		
	if GameManager.minutes >=12 and is_boss_on_screen ==false:
		var boss_instance = boss.instantiate()
		boss_instance.position = GameManager.player_position + Vector2(500, 500)
		add_child(boss_instance)
		is_boss_on_screen = true

#-------------------------------------------------- Chamar Game Over

func trigger_game_over():
	# Deletar GameUI
	
	if game_ui:
		game_ui.queue_free()
		game_ui = null
	
	
		# Criar GameOverUI 
	if game_over_ui_template:		
		game_over_instance = game_over_ui_template.instantiate()
		add_child(game_over_instance)
		
#-------------------------------------------------- Chamar menus do pause

func toggle_pause():

	GameManager.menu_open = true
	get_node("PauseMenu").came_from_level = true
	get_node("PauseMenu").show()
	if Input.is_joy_known(0):
		get_node("PauseMenu").get_node("%Statistics").grab_focus()
		get_node("PauseMenu").confirm_sfx()
	get_tree().paused = true
	
	#options.get_node("%BGM").grab_focus()
	

#-------------------------------------------------- Alterar o volume

func _update_bgm_volume(value):
	bgm_audio.volume_db = linear_to_db(value)

#func _update_sfx_volume(value):
	#sfx_audio.volume_db = linear_to_db(value)

func linear_to_db(value):
	return 20 * log(value) / log(10)
