extends Node2D

@export var damage_amount: int = 1
@onready var area2d: Area2D = $Area2D


var direction: Vector2 = Vector2.ZERO
var cont: float = 0.0


func _process(delta):
	position += direction * 300 * delta
	cont += delta
	deal_damage()
	
	
	if cont >= 2:
		cont=0
		queue_free()
		
	
func set_direction(dir: Vector2):
	direction = dir

func deal_damage():
	
	
	var bodies = area2d.get_overlapping_bodies()	
	for body in bodies:
		if body.is_in_group("enemies"):
			
			var enemy= body
			enemy.damage(damage_amount)	
