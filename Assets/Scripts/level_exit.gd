extends Area2D
class_name LevelExit

func _on_body_entered(body):
	if GameManager.exit_is_open && body is PlayerController:
		GameManager.next_level()
