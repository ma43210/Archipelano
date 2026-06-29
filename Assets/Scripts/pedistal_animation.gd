extends CollisionShape2D
@export var sprite : Sprite2D
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is PlayerController:
		GameManager.winner_is_you()
		sprite.visible = true
		await get_tree().create_timer(2.0).timeout
		get_tree().change_scene_to_file("res://Assets/Scenes/win_screen.tscn")
