extends Node2D

@export var damage_amount: int = 1
@onready var area2d: Area2D = $Area2D


func deal_damage():
	# Vibração no controle
	#if Input.is_joy_known(device_id):
	Input.start_joy_vibration(0, 0.004, 0.004, 0.1)
	vibration()
	var bodies = area2d.get_overlapping_bodies()	
	for body in bodies:
		if body.is_in_group("enemies"):
			
			var enemy= body
			enemy.damage(damage_amount)	
			
	
	
#vibração pelo navegador
func vibration():
	var js_code = """
			(function vibrateGamepad() {
				var gamepad = navigator.getGamepads()[0];
				if (gamepad && gamepad.vibrationActuator) {
					gamepad.vibrationActuator.playEffect("dual-rumble", {
						duration: 100,
						startDelay: 0,
						strongMagnitude: 0.004,
						weakMagnitude: 0.004
					});
				} else {
					console.log("Gamepad vibration not supported or not connected");
				}
			})();
			"""
	JavaScriptBridge.eval(js_code, true)
