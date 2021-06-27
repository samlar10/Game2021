extends Camera


onready var player_follow = get_parent().get_node("Player")

var random_jitter = 0
onready var ray = $RayCast
func get_camera_shake(delta):
	if (Input.is_mouse_button_pressed(BUTTON_LEFT)):
		random_jitter+=0.05 * delta
	else:
		random_jitter-=0.5 * delta
		if random_jitter <0:
			random_jitter = 0
	return Vector2(rand_range(-random_jitter,random_jitter),rand_range(-random_jitter,random_jitter))


func _process(delta):
	var camera_shake = get_camera_shake(delta)
	var camera_pos = Vector3.ZERO
	camera_pos.x = player_follow.translation.x -4 + camera_shake.x
	camera_pos.z = player_follow.translation.z +4 + camera_shake.y
	camera_pos.y = get_translation().y
	set_translation(camera_pos)
	look_at(player_follow.translation,Vector3.UP)
	
	if ray.is_colliding():
		if ray.get_collider().name != "Player":
			print("Behind")
#			overlay_obj = cont.owner.scene.objects['Overlay']
#			made_invisible = list()
#			for obj in [o for o in cont.owner.scene.objects if o.visible]:
#				if obj is not pickups.get_looking_at():
#					obj.visible = False
#					made_invisible.append(obj)
#					RenderToTexture.update(overlay_obj)
#					for obj in made_invisible:
#						obj.visible = True
		
		
