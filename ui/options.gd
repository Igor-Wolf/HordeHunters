class_name	Options
extends CanvasLayer

var timer: float = 0

@onready var bgm_slider = %BGM
@onready var sfx_slider = %SFX
@onready var bgm_text = %BGMVolume
@onready var sfx_text = %SFXVolume

#@export var pause_menu : PackedScene

func _ready():
	if Input.is_joy_known(0):
		%BGM.grab_focus()
	# Definir valores iniciais dos sliders
	bgm_slider.value = GameManager.bgm_volume *100
	sfx_slider.value = GameManager.sfx_volume *100
	bgm_text.text = str(GameManager.bgm_volume)
	sfx_text.text = str(GameManager.sfx_volume)
	
	bgm_slider.max_value = 100
	sfx_slider.max_value = 100		
	
	# Conectar sliders aos métodos do GameManager
	bgm_slider.connect("value_changed", Callable(self, "_on_bgm_slider_changed"))
	sfx_slider.connect("value_changed", Callable(self, "_on_sfx_slider_changed"))

func _process(delta):
	bgm_text.text = str(bgm_slider.value)
	sfx_text.text = str(sfx_slider.value)
	
	if Input.is_action_just_pressed("confirm_button") or Input.is_action_just_pressed("ui_accept"):
		_on_confirm_button()


func _on_confirm_button():
	var focused_button = get_viewport().gui_get_focus_owner()         
	if focused_button == $Panel2/Return:
		
		_on_return_pressed()
#--------------------------------------------- Alterar o audio

func _on_bgm_slider_changed(value):
	GameManager.set_bgm_volume(value/100)
	
func _on_sfx_slider_changed(value):
	GameManager.set_sfx_volume(value/100)

func _on_return_pressed():
	
	get_parent().get_node("%PauseMenu").show()
	if Input.is_joy_known(0):
		get_parent().get_node("%PauseMenu").get_node("%Options").grab_focus()

	hide()
		

#-------------------------------------------------- Mouse hover sfx
func _on_bgm_mouse_entered():
	get_parent().get_node("PauseMenu").sfx_menu()


func _on_sfx_mouse_entered():
	get_parent().get_node("PauseMenu").sfx_menu()


func _on_return_mouse_entered():
	get_parent().get_node("PauseMenu").sfx_menu()
