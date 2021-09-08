extends Node

export var fire_rate = 0.5
export var clip_size = 30
export var reload_rate = 1
onready var ammo_label = $"../UI/Label"
onready var gunray = $"../GunRay"
onready var particles = preload("res://World_scenes/scenes/Particles.tscn")

var current_ammo = clip_size
var can_fire = true
var reloading = false

func _process(delta):
	ammo_label.set_text("%d / %d" % [current_ammo, clip_size])

	if Input.is_action_pressed("primary_fire") and can_fire:
		if current_ammo > 0 and not reloading:
			print("bang")
			can_fire = false
			current_ammo -= 1
			yield(get_tree().create_timer(fire_rate), "timeout")
			var p = particles.instance()
			gunray.get_collider().add_child(p)
			p.global_transform.origin = gunray.get_collision_point()
			can_fire = true
		elif not reloading:
			print("reloading")
			reloading = true
			yield(get_tree().create_timer(reload_rate), "timeout")
			current_ammo = clip_size
			reloading = false
			print("reloded")
