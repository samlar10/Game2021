extends KinematicBody

var gravity = Vector3.DOWN * 80 # strength of gravity

var speed = 6  # movement speed

var jump_speed = 18  # jump strength

var spin = 0.1  # rotation speed

onready var camera = get_parent().get_node("Camera")
var cursor_pos = Vector3.ZERO
var velocity = Vector3()
var jump = false

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
	velocity.x = 0
	velocity.z = 0
	if Input.is_action_pressed("ui_left"):
		velocity.z -= speed
		velocity.x -= speed
	if Input.is_action_pressed("ui_right"):
		velocity.x += speed
		velocity.z += speed
	if Input.is_action_pressed("ui_up"):
		velocity.x += speed
		velocity.z -= speed
	if Input.is_action_pressed("ui_down"):
		velocity.x -= speed
		velocity.z +=speed
		
	jump = false
	if Input.is_action_just_pressed("ui_accept"):
		jump = true

func _physics_process(delta):
	velocity += gravity * delta
	get_input()
	velocity = move_and_slide(velocity, Vector3.UP,true)
	look_at_curser()
	if jump and is_on_floor():
		velocity.y = jump_speed
