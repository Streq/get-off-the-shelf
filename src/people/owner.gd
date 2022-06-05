extends Node2D

onready var anim := $AnimationPlayer

var checking = false

func _ready():
	get_tree().connect("node_added", self, "_on_node_added")
	for client in get_tree().get_nodes_in_group("client"):
		_on_node_added(client)

func _on_node_added(node):
	if node.is_in_group("client"):
		node.connect("saw_fairy", self, "_on_saw_fairy")
	

func _on_saw_fairy():
	anim.play("turn_around")


func _physics_process(delta):
	if checking:
		var boxes = get_tree().get_nodes_in_group("box")
		for box in boxes:
			if box.is_moving():
				Global.lose()

func _check_fairy():
	checking = true

func _stop_checking_fairy():
	checking = false
	anim.play("idle")
