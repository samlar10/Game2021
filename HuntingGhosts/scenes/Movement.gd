extends KinematicBody

onready var camera = get_parent().get_node("Camera")
onready var floor_ray = $FloorRay

export var max_speed = 10
export var friction = 10
export var speed = 1
export var acceleration = 0.5
var gravity = Vector3.DOWN * 12
export var jumpforce = 200
var on_ground =true
var jump = false
var move_vector = Vector3.ZERO
var cursor_pos = Vector3.ZERO



func look_at_curser():
	var player_pos = global_transform.origin
	var drop_plane = Plane(Vector3(0,1,0), player_pos.y)
	var ray_length = 1000
	var mouse_pos = get_viewport().get_mouse_position()
	var from = camera.project_ray_origin(mouse_pos)
	var to = from + camera.project_ray_normal(mouse_pos) * ray_length
	cursor_pos = drop_plane.intersects_ray(from,to)
	#print(cursor_pos)
	look_at(cursor_pos, Vector3.UP)
	
func get_input():
	var input = Vector3.ZERO
	
	on_ground = floor_ray.is_colliding()
	if floor_ray.get_collider() != null:
		print(floor_ray.get_collider().get_parent().name)
	
	jump = false
	if Input.is_action_just_pressed("ui_accept"):
		jump = true
	
		

	if Input.get_action_strength("ui_left"):
		input.z = -speed
		input.x = -speed
	if Input.get_action_strength("ui_right"):
		input.z = +speed
		input.x = +speed
	if Input.get_action_strength("ui_down"):
		input.z = +speed
		input.x = -speed
	if Input.get_action_strength("ui_up"):
		input.z = -speed
		input.x = +speed
	input = input.normalized()  	
	return input
	
	
	
#	var input = Vector3(
#		-int(Input.is_action_pressed("ui_left")) +int(Input.is_action_pressed("ui_right")),
#		0,
#		-int(Input.is_action_pressed("ui_up")) +int(Input.is_action_pressed("ui_down"))
#	)
	

	
func _process(delta):
	pass
	
func _physics_process(delta):

	move_vector += gravity * delta
	var grav = move_vector.y
	move_vector += get_input() 
	if jump and on_ground:
		move_vector.y = jumpforce
	move_vector = move_and_slide(move_vector,Vector3.UP)
	move_vector = move_vector.move_toward(Vector3.ZERO,acceleration)
	move_vector.y= grav
	look_at_curser()
#func _physics_process(delta):
#	var input = get_input()
#	if input != Vector3.ZERO:
#		speed += acceleration
#		if speed > max_speed:
#			speed = max_speed
#
#
#
#	move_vector = input * speed
#	move_vector.y -= gravity *delta
#	if Input.get_action_strength("ui_jump")  and on_ground:
#		print("jumping")
#		move_vector.y += jumpforce
#	move_vector = move_and_slide(move_vector,Vector3.UP, true)
#
#	look_at_curser()
