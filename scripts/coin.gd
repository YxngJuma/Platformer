extends Area2D

@onready var game_manager = %GameManger
@onready var animation_player= $AnimationPlayer


func _on_body_entered(body:Node2D):
	print("pickup")
	game_manager.add_point()
	animation_player.play("pickup")
