extends RigidBody
#
#func _process():
#	if Input.is_action_pressed("player_fire") and can_fire:
#		can_fire = false
#		$Timer.start()

func _ready():
	add_to_group("ignore")


func _on_VisibilityNotifier_camera_exited(camera):
	queue_free()


func _on_Timer_timeout():
	queue_free()
