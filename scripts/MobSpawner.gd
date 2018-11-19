extends Node2D

export (PackedScene) var Mob
export (float) var SpawnRate

func _ready():
	$MobTimer.wait_time = SpawnRate

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_MobTimer_timeout():
	# spawn a mob
	var mob = Mob.instance()
	mob.position = Vector2(100, 100)
	mob.connect("die", self, "_on_mob_die")
	add_child(mob)

func _on_mob_die(mob):
	GameState.add_score(10)
	GameState.spawn_random_seed(mob.position)
	remove_child(mob)
	