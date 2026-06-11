extends Area2D
class_name HurtBox
func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body is TileMapLayer:
		owner.dead = true
