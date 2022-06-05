extends Node


func lose():
	
	$pivot/lose_label.visible = true
	$lose_timer.start()
	get_tree().paused = true
	yield($lose_timer, "timeout")
	get_tree().paused = false
	get_tree().reload_current_scene()
	$pivot/lose_label.visible = false
