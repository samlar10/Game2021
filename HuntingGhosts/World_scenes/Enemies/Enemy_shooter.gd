extends KinematicBody

var Player
var damage = 30
var follow_player = false
var move_speed = 200
var can_shoot = false
var gravity = Vector3.DOWN * 1000
var health = 50
onready var bullet
onready var shoottimer = $ShootTimer
onready var health_display = $UI/Label3


func _ready():
	pass

func _process(delta):
	if health <= 0:
		queue_free()
		print("killed")
	

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
		shoottimer.start()
		
#	sends signal when player is near by


func _on_Area_body_exited(body):
	if body.name == "Player":
		$RayCast.set_enabled(false)
		follow_player = false
		shoottimer.stop()

# sends signal for when the player leaves


func _on_ShootTimer_timeout():
	if $RayCast.is_colliding():
		var hit = $RayCast.get_collider()
		if hit.is_in_group("Player"):
			print("hit")
			hit.health -= damage
			
			
