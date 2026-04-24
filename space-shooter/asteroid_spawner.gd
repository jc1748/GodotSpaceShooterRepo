extends Node2D

signal asteroid_destroyed(position)

var spawn_positions = null
var current_asteroid = null

var Asteroid = preload("res://asteroid.tscn")

func _ready():
	randomize()
	spawn_positions = $Positions.get_children()
	
func spawn_asteroid():
	var index = randi() % spawn_positions.size()
	var asteroid = Asteroid.instantiate()
	asteroid.global_position = spawn_positions[index].global_position
	
	asteroid.asteroid_destroyed.connect(_on_asteroid_destroyed)
	asteroid.tree_exited.connect(_on_asteroid_removed)
	
	add_child(asteroid) 
	
func _on_spawn_timer_timeout() -> void:
	spawn_asteroid()
	
func _on_asteroid_destroyed(position):
	asteroid_destroyed.emit(position)

func _on_asteroid_removed():
	current_asteroid = null
	
