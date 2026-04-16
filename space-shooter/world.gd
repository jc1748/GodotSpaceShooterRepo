extends Node2D

var Laser = preload("res://Projectiles/player_laser.tscn")

@onready var player = $Player

@onready var enemy_spawner = $Enemy_Spawer

var score = 0

func _ready():
	player.spawn_laser.connect(_on_player_spawn_laser)
	enemy_spawner.add_score.connect(add_score)
	$Score.text = "Score: "+ str(score)
	
func _on_player_spawn_laser(location: Variant) -> void:
	var l = Laser.instantiate()
	print("laser instantiated: ", l)

	get_tree().current_scene.add_child(l)
	l.global_position = location

	print("laser position after spawn: ", l.global_position)

func add_score():
	score += 10
	$Score.text = "Score: " + str(score)
