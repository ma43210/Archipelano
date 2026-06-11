extends Area2D


func _on_body_entered(body):
	if body is PlayerController:
		GameManager.add_key()
		queue_free()
