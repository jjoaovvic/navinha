extends Node2D

func spawn_enemy():
	var pursuer = preload("res://prefabs/pursuer.tscn").instantiate()
	%Spawner.progress_ratio = randf()
	pursuer.global_position = %Spawner.global_position
	add_child(pursuer)


func _on_pursuer_timer_timeout() -> void:
	spawn_enemy()
