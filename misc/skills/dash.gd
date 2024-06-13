extends Node2D


@onready var colision = $Area2D
@export var knockback: int = 20
@export var damage_amount: int = 2

var cont = 0.3

func _process(delta):
	
	cont-=delta
	update_knockback()
	
	if cont <= 0:
		queue_free()
	
	
func update_knockback():
	var bodies = colision.get_overlapping_bodies()
	for body in bodies:
		if body.is_in_group("enemies"):
			body.knockback(knockback)
			body.damage(damage_amount)
