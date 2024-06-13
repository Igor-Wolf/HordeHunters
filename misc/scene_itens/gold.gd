extends Node2D

@export var gold_amount: int = 1
var time_destruction: float = 0


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
		player.gold_collected.emit(gold_amount)
		queue_free()
		
	
