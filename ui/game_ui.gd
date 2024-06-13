extends CanvasLayer

@onready var timer_label: Label = %TimerLabel
@onready var meat_label: Label = %MeatLabel
@onready var gold_label: Label = %GoldLabel

@onready var exp_progress_bar : ProgressBar = %ProgressBar
@onready var exp_label: Label = %Exp
@onready var lv_label: Label = %Lv

func _process(delta):
	
	# Formatar e atualizar o texto do timer_label
	timer_label.text = GameManager.time_elapsed_string
	meat_label.text = str("DEBUG: " ,GameManager.enemy_on_screen)
	gold_label.text = str(GameManager.gold_counter)
	
	exp_label.text = str("EXP: " , GameManager.curent_experience)
	lv_label.text = str("LV: " , GameManager.current_level)

	
	exp_progress_bar.max_value = GameManager.next_level - GameManager.last_level
	exp_progress_bar.value = GameManager.curent_experience - GameManager.last_level
	

