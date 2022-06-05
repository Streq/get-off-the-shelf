extends Node2D

signal saw_fairy()

onready var anim := $AnimationPlayer
export var target_x = 0.0

export var speed = 100.0

var alert = false


func _physics_process(delta):
	var fairies = $can_see_fairy_area.get_overlapping_bodies()
	var fairy_moved = false
	if fairies.size():
		var fairy_box = fairies[0]
		if fairy_box.is_moving():
			alert = true
			fairy_moved = true
			if anim.current_animation != "turn_around":
				anim.play("turn_around")
	
	if !fairy_moved and (anim.current_animation != "turn_around" or !anim.is_playing()):
		alert = false

	if !alert:
		if target_x != global_position.x:
			anim.play("walk")
			global_position.x = Math.approach(global_position.x, target_x, delta * speed)
		else:
			anim.play("idle")

func signal_owner():
	emit_signal("saw_fairy")
