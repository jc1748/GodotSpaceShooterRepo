extends Node2D

var spawn_positions = null

signal add_score

var Enemy = preload("res://Characters/enemy/enemy.tscn")

func _ready():
	randomize()
	spawn_positions = $Positions.get_children()
	
func spawn_enemy():
	var index = randi() % spawn_positions.size()
	var enemy = Enemy.instantiate()
	enemy.global_position = spawn_positions[index].global_position
	enemy.enemy_died.connect(enemy_died)
	add_child(enemy) 
	
func _on_spawn_timer_timeout() -> void:
	spawn_enemy()
	
func enemy_died():
	add_score.emit()
