extends Node

var current_seed: int
var player_count: int = 2


func _ready() -> void:
	current_seed = randi()
	print("Seed: ", current_seed)
