extends RigidBody2D

export var speed := 0.0
export var jump_speed := 0.0


onready var anim := $AnimationPlayer

var jump_accumulator := 0.0

func _ready():
	contact_monitor = true
	contacts_reported = 1
	

func _input(event):
	if event.is_action_pressed("restart"):
		get_tree().reload_current_scene()

func _physics_process(delta):
	if Input.is_action_pressed("ui_accept"):
		jump_accumulator += delta * 3
		jump_accumulator = clamp(jump_accumulator, 0.0, 3.0)
	else:
		jump_accumulator = 0.5

func _integrate_forces(state: Physics2DDirectBodyState):
	var dir = InputUtils.get_input_dir().normalized()
	
	if anim.is_playing() and anim.current_animation == "dash":
		$Sprite.global_rotation = 0
	elif dir != Vector2.ZERO and !Input.is_action_pressed("ui_accept"):
		anim.play("fly")
		$Sprite.global_rotation = 0
	else:
		anim.play("idle")
		
	if !Input.is_action_pressed("ui_accept"):
		linear_velocity += dir * speed * state.step
		
#	contact based jump
#	if state.get_contact_count():
#		var jump_dir = state.get_contact_local_normal(0)
#
#		var object_against : RigidBody2D = state.get_contact_collider_object(0)
#		var object_position = state.get_contact_collider_position(0)
#
#		if Input.is_action_just_released("ui_accept"):
#			var jump_impulse = jump_dir * jump_speed * jump_accumulator
#			object_against.apply_impulse(object_against.to_local(object_position), -jump_impulse)
#			apply_central_impulse(jump_impulse)
#	direction based jump
	if Input.is_action_just_released("ui_accept"):
		var jump_impulse = dir * jump_speed * jump_accumulator
		apply_central_impulse(jump_impulse)
		anim.play("dash")
