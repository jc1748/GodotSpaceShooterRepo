extends Node2D

var Laser = preload("res://Projectiles/player_laser.tscn")

@onready var player = $Player
@onready var enemy_spawner = $Enemy_Spawer
@onready var ammo_label = $AmmoCount
@onready var asteroid_spawner = $AsteroidSpawner

var PowerUp = preload("res://power_up.tscn")

var score = 0

func _ready():
	player.ammo_changed.connect(update_ammo_ui)
	update_ammo_ui(player.ammo, player.max_ammo) #set the initial value
	
	player.spawn_laser.connect(_on_player_spawn_laser)
	enemy_spawner.add_score.connect(add_score)
	$Score.text = "Score: "+ str(score)
	
	asteroid_spawner.asteroid_destroyed.connect(spawn_powerup)
	
func _on_player_spawn_laser(location: Variant) -> void:
	var l = Laser.instantiate()
	print("laser instantiated: ", l)

	get_tree().current_scene.add_child(l)
	l.global_position = location

	print("laser position after spawn: ", l.global_position)
	
func update_ammo_ui(current_ammo, max_ammo):
	ammo_label.text = "Ammo: " + str(current_ammo) + "/" + str(max_ammo)

func add_score():
	score += 10
	$Score.text = "Score: " + str(score)

func spawn_powerup(location):
	var p = PowerUp.instantiate()
	get_tree().current_scene.add_child(p)
	p.global_position = location
