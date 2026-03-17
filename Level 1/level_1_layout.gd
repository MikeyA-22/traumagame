extends Node3D

@export var player: Player
@export var spawn_point : Node3D

var monster_resource = preload("res://Enemy/BT_base_enemy.tscn")

var monster : Enemy
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_monster()
	Game_Global.current_gState = Game_Global.game_state.STATE_ENEMY_ATTACK
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func spawn_monster():
	monster = monster_resource.instantiate()
	monster.position = spawn_point.position
	add_child(monster)
	player.monster = monster
	SigBus.SETMONSTER.emit(monster)
