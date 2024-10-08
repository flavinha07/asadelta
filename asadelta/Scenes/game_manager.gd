extends Node

@onready var bird = $"../Bird" as Bird
@onready var pipes_spawner = $"../PipesPawner" as PipeSpawner
@onready var ground = $"../Ground" as Ground
@onready var fade = $"../Fade" as Fade
@onready var ui = $"../UI" as UI


var points = 0

func _ready():
	bird.game_started.connect(on_game_started)
	ground.bird_crashed.connect(end_game)
	pipes_spawner.bird_crashed.connect(end_game)
	pipes_spawner.point_scored.connect(on_point_scored)
	
func on_game_started():
	pipes_spawner.start_spawning_pipes()
	

func end_game():
	if fade != null:
		fade.play()
	ground.stop()
	bird.kill()
	pipes_spawner.stop()
	ui.on_game_over(true)
	
func on_point_scored():
	points += 1
	ui.update_points(points)
