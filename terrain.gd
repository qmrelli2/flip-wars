extends Node2D

export var width = 128
export var height = 75

const TILES = {
	'water': 0,
	'grass': 1,
	'dirt': 2,
	'snow': 3
}
 
onready var tilemap = $TileMap
var noise = OpenSimplexNoise.new()

func _ready():
	randomize()
	noise.seed = randi()
	noise.octaves = 4
	noise.period = 15.0
	noise.persistence = 0.75
	noise.lacunarity = 1.5
	 
	generate_map()
	
func generate_map():
	for x in width:
		for y in height:
			tilemap.set_cellv(Vector2(x - width / 2, y - height / 2), getTileIndex(noise.get_noise_2d(float(x), float(y))))
	tilemap.update_bitmask_region()
			
func getTileIndex(noise_sample):
	print(noise_sample)
	if noise_sample < 0:
		return TILES.water
	if noise_sample < 0.3:
		return TILES.snow	
	if noise_sample < 0.2:
		return TILES.dirt	
	return TILES.grass
	
func _input(event: InputEvent):
	if event.is_action_pressed("ui_space"):
		get_tree().reload_current_scene()
