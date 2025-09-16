extends Node
class_name AIstate

@export var move_name: String
@export var animation: String

var player : CharacterBody3D
var character: CharacterBody3D
var animator : AnimationPlayer
var spawn_point : Vector3
var right_weapon : Weapon
var resources : EnemyResources

func _ready() -> void:
	pass#animation = "ANIMATION GOES HERE"

# Step 3: implement a check_relevance function
func check_request(input: InputPackage):
	pass

# Step 4: implement an update function
func update(input: InputPackage, delta: float):
	pass

## Step 5: DELETE THE COMMENTS!! DUMMY...
