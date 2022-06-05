extends Node2D
export var client_scene :PackedScene

func spawn_client():
	var r = randi()%2
	var spawn_point = get_child(r)
	var client = client_scene.instance()
	get_parent().add_child(client)
	var sp = spawn_point.global_position
	client.global_position = sp
	if r:
		client.target_x = -1000.0
	else:
		client.target_x = 1000.0
	


func _on_Timer_timeout():
	spawn_client()
