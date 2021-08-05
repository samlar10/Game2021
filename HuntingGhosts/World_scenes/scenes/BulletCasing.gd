extends RigidBody



func _ready():
	add_to_group("ignore")


func _on_VisibilityNotifier_camera_exited(camera):
	pass # Replace with function body.
