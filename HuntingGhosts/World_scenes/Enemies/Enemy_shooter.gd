extends KinematicBody

var Player
var follow_player = false
var move_speed = 100
var can_shoot = false
onready var bullet

func _ready():
	pass

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
# sends signal for when the player leaves
