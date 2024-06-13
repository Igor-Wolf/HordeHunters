extends Node2D

@export var regeneration_amount: int = 10

var time_destruction: float = 0

#@onready var root_node = $"."

func _ready():
	$Area2D.body_entered.connect(on_body_entered)
	
	
func _process(delta):
	
	time_destruction +=delta
	
	if time_destruction >= 8.0:		
		queue_free()
		time_destruction=0

func on_body_entered(body: Node2D):
	if body.is_in_group("player"):
		var player: Player = body
		player.heal(regeneration_amount)
		player.meat_collected.emit(regeneration_amount)
		queue_free()
		
	

