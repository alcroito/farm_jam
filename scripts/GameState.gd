extends Node

# constants
const TILE_SIZE = 32

# class member variables go here, for example:
onready var hud = get_node("/root/Game/HUD")

var crop_names = ["Artichoke", "Cucumber", "Potato", "Tomato"]

var equipped_seed_index = 0
# dictionary that map crop name string to counts
var seed_counts = {}
# dictionary that map crop name string to scenes
var crop_scenes = {}
var picked_up_seed = null
var coin_count = 0
var score = 0

func _ready():
	for crop in crop_names:
		seed_counts[crop] = 0
		crop_scenes[crop] = load("res://scenes/" + crop + ".tscn")
	print(crop_scenes)
	
func has_seeds():
	return seed_counts[crop_names[equipped_seed_index]] > 0
		
func plant_active_crop():
	if has_seeds():
		var seed_name = crop_names[equipped_seed_index]
		seed_counts[seed_name] -= 1
		hud.update_labels()
		return crop_scenes[seed_name].instance()
	return null
		
func add_coins(num_coins):
	coin_count += num_coins
	hud.update_labels()	

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	if Input.is_action_just_released("pick_seed"):
		equipped_seed_index = (equipped_seed_index + 1) % crop_names.size()
		hud.update_labels()
	
# Connections
func _on_Seed_picked_up(_seed):
	picked_up_seed = _seed
	seed_counts[picked_up_seed.type] += 1
	hud.update_labels()

