extends Node2D

@export var damage_amount: int = 1
@onready var areas: Array = [$Images/Area2D1, $Images/Area2D2, $Images/Area2D3]


var direction: Vector2 = Vector2.ZERO
var cont: float = 0.0


func _process(delta):
	cont += delta
	deal_damage()
	
	
	if cont >= 2.5:
		cont=0
		queue_free()
		
	
func deal_damage():
	for area in areas:	
		var bodies = area.get_overlapping_bodies()	
		for body in bodies:
			if body.is_in_group("enemies"):
				
				var enemy= body
				enemy.damage(damage_amount)	
