extends Node

export var pfire_rate = 0.2
export var sfire_rate = 0.5
export var clip_size = 30
export var reload_rate = 1
export var damage = 25
onready var ammo_label = $"../UI/Label"
onready var gunray = $"../GunRay"
onready var particles = preload("res://World_scenes/scenes/Particles.tscn")

var aiming = false
var current_ammo = clip_size
var can_fire = true
var reloading = false

func _process(delta):
	ammo_label.set_text("%d / %d" % [current_ammo, clip_size])
#	this shows the player how much ammo is in the gun. just a place holder until I design the new ammo icons and code for them.

	if Input.is_action_pressed("primary_fire") and can_fire:
		if current_ammo > 0 and not reloading:
			print("bang")
			can_fire = false
			current_ammo -= 1
			check_collision()
			yield(get_tree().create_timer(pfire_rate), "timeout")
			var p = particles.instance()
			gunray.get_collider().add_child(p)
			p.global_transform.origin = gunray.get_collision_point()
			print("explosion")
			can_fire = true
		elif not reloading:
			print("reloading")
			reloading = true
			yield(get_tree().create_timer(reload_rate), "timeout")
			current_ammo = clip_size
			reloading = false
			print("reloded")
#how the player fires, makes sure the player has ammo in their gun and if they dont then they can't shoot and reloads for them
func check_collision():
	if gunray.is_colliding():
		var target = gunray.get_collider()
		if target.is_in_group("Enemies"):
			target.health -= damage
			print("hit" + target.name)

		
#(to be done) add function where the  player "aims in" send signal out so that fire rate changes see trello for brainstorm
#
#	if Input.is_action_pressed("ui_aim") and can_fire and not aiming:
#		if current_ammo > 0 and not reloading:
#			aiming = true
#			print("aimed")
#			can_fire = false
#			current_ammo -= 1
#			yield(get_tree().create_timer(sfire_rate), "timeout")
#			var p = particles.instance()
#			gunray.get_collider().add_child(p)
#			p.global_transform.origin = gunray.get_collision_point()
#			can_fire = true
#		elif not reloading:
#			print("reloading")
#			reloading = true
#			yield(get_tree().create_timer(reload_rate), "timeout")
#			current_ammo = clip_size
#			reloading = false
#			print("reloded")
