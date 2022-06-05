extends RigidBody2D


func _process(delta):
	print(is_moving())
	
func is_moving():
	return linear_velocity.length() > 20.0 or angular_velocity > 1.0
