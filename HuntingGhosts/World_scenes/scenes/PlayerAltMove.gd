extends KinematicBody

onready var tracer = preload("res://World_scenes/scenes/TracerFire.tscn")
onready var spark = preload("res://World_scenes/scenes/Particles.tscn")
onready var case = preload("res://World_scenes/scenes/BulletCasingRemake.tscn")


var gravity = Vector3.DOWN * 80 # strength of gravity
var speed = 6  # movement speed
var jump_speed = 18  # jump strength
var spin = 0.1  # rotation speed
onready var gunray= $"GunRay"
onready var camera = get_parent().get_node("SpringArm/Camera")
var cursor_pos = Vector3.ZERO
var velocity = Vector3()
var jump = false
var delt = 0
#var can_fire = true
#
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)



func _input(event):
	var turn_speed = 0.005
#	print(event)
	if event is InputEventMouseMotion:
		
#		print("mousemove", event.get_relative())
		rotate_y(turn_speed * -event.get_relative().x )
		
func look_at_curser():
	pass
#	var player_pos = global_transform.origin
#	var drop_plane = Plane(Vector3(0,1,0), player_pos.y)
#	var ray_length = 1000
#	var mouse_pos = get_viewport().get_mouse_position()
#	var from = camera.project_ray_origin(mouse_pos)
#	var to = from + camera.project_ray_normal(mouse_pos) * ray_length
#	cursor_pos = drop_plane.intersects_ray(from,to)
#	print(cursor_pos)
#	look_at(cursor_pos, Vector3.UP)


func get_input():
	var vy = velocity.y
	velocity = Vector3()
	if Input.is_action_pressed("ui_up"):
		velocity += -transform.basis.z * speed
	if Input.is_action_pressed("ui_down"):
		velocity += transform.basis.z * speed
	if Input.is_action_pressed("ui_right"):
		velocity += transform.basis.x * speed
	if Input.is_action_pressed("ui_left"):
		velocity += -transform.basis.x * speed
	velocity.y = vy


#	velocity.x = 0
#	velocity.z = 0
#	if Input.is_action_pressed("ui_left"):
#		velocity.z -= speed
#		velocity.x -= speed
#	if Input.is_action_pressed("ui_right"):
#		velocity.x += speed
#		velocity.z += speed
#	if Input.is_action_pressed("ui_up"):
#		velocity.x += speed
#		velocity.z -= speed
#	if Input.is_action_pressed("ui_down"):
#		velocity.x -= speed
#		velocity.z +=speed
		
	jump = false
	if Input.is_action_just_pressed("ui_accept"):
		jump = true 
#	code behind players movement

func _physics_process(delta):
	delt = delta
	velocity += gravity * delta
	get_input()
	velocity = move_and_slide(velocity, Vector3.UP,true)
	look_at_curser()
	if jump and is_on_floor():
		velocity.y = jump_speed
# code that stop the player from being able to continually jump

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		if event.relative.x > 0:
			rotate_y(-lerp(0, spin, event.relative.x/10))
		elif event.relative.x < 0:
			rotate_y(-lerp(0, spin, event.relative.x/10))
# code that allows the player to rotate relitive to the mouse

#					Old shooting code where it used projectivles instead of the new and improved raycast
func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
#	pass
#	if Input.is_action_pressed("player_fire") and can_fire:
#		can_fire = false
#		var new_case = case.instance()
#		new_case.global_transform = $Case_Ejector.global_transform
#		get_parent().add_child(new_case)
#		print(get_parent().name)
#		print(new_case.global_transform)
#
#		if gunray.is_colliding():
#			var collision_point= gunray.get_collider().global_transform
#			var s = spark.instance()
#			s.global_transform = collision_point
#			get_parent().add_child(s)
#
#		var new_tracer = tracer.instance()
#		new_tracer.global_transform = $gun_barrel.global_transform
#		get_parent().add_child(new_tracer)
#
#		$GunTimer.set_wait_time($GunTimer.get_wait_time() - 0.05)
#		$GunTimer.start()
#	if not Input.is_action_pressed("player_fire"):
#		$GunTimer.set_wait_time($GunTimer.get_wait_time() + 0.1)
#		if $GunTimer.get_wait_time() > 0.3:
#			$GunTimer.set_wait_time(0.3)

#
#func _on_GunTimer_timeout():
#	can_fire = true
