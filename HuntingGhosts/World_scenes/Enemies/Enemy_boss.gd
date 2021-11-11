extends KinematicBody

var Player
var follow_player = false
var move_speed = 200
var can_shoot = false
var gravity = Vector3.DOWN * 1000
var health = 100
var damage = 5
onready var bullet
#onready var UI = preload("res://World_scenes/scenes/UI.tscn")
signal boss_death


func _ready():
	pass

func _process(delta):
	if health <= 0:
		#emit_signal("Boss_death")
		get_tree().call_group("Player","_on_Boss_death")
		#print("signal sent")
		queue_free()
		#when the boss dies it sends out the signal so that code for the player can identify whenit dies being able to show the winning text and then reture in to the title screen

	

func _physics_process(delta):
	if follow_player == true:
		var pos = Player.global_transform.origin
		var facing = -global_transform.basis.z
		look_at(pos, Vector3.UP)
		if $RayCast.get_collider() != null:
			if $RayCast.get_collider().name == "Player":
				move_and_slide(facing *  move_speed * delta, Vector3.UP)
#	code for how it follows the player


func _on_Area_body_entered(body):
	if body.name == "Player":
		$RayCast.set_enabled(true)
		follow_player = true
		Player = body
#	sends signal when player is near by


func _on_Area_body_exited(body):
	if body.name == "Player":
		$RayCast.set_enabled(false)
		follow_player = false




func _on_Timer_timeout():
	if $RayCast.is_colliding():
		var hit = $RayCast.get_collider()
		if hit.is_in_group("Player"):
			print("hit")
			hit.health -= damage
