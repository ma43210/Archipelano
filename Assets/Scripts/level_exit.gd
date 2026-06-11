extends Area2D
class_name LevelExit

var is_open = false
func _ready():
	close()
	
func open():
	is_open = true

func close():
	is_open = false

func _on_body_entered(body):
	if is_open && body is PlayerController:
		GameManager.next_level()
