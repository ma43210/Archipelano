extends Area2D
class_name LevelExit

var is_open = false
func _ready():
	is_open = false
	
func open():
	self.is_open = true
	print("YAY!!!!!!!")


func _on_body_entered(body):
	print("e")
	if is_open && body is PlayerController:
		GameManager.next_level()
		print("YAY")
